package main

import (
	"errors"
	"io/fs"
	"log"
	"os"
	"os/exec"
	"path/filepath"
	"sort"
	"strings"

	"github.com/charmbracelet/huh"
)

const notesDir = "/Documents/Syncthing/Obsidian_Vault"

func main() {
	directories := getDirectories()

	opts := convertDirToOpt(directories)

	note, dir, newDir := createHuhForm(opts)

	if len(newDir) != 0 {
		dir = dir + "/" + newDir

		if err := os.Mkdir(dir, os.ModePerm); err != nil {
			log.Fatalf("Could not create directory, %v", err)
		}

	}

	openFile(note, dir)
}

// Get all the directories under my notes directory.
func getDirectories() map[string]string {
	homeDir, err := os.UserHomeDir()
	if err != nil {
		log.Fatalf("Could not get user's home directory: %v", err)
	}

	directories := make(map[string]string)
	var absPath string

	err = filepath.Walk(homeDir+notesDir, func(path string, info fs.FileInfo, err error) error {
		if err != nil {
			log.Printf("Error walking the path: %v", err)
			return err
		}

		absPath, err = filepath.Abs(homeDir + notesDir)
		if err != nil {
			log.Printf("Error getting the absolute path of %s, [%v]", homeDir+notesDir, err)
		}

		if info.IsDir() {
			// Ignore the ".git" and ".obsidian" sub-directories
			if info.Name() == ".git" || info.Name() == ".obsidian" {
				return filepath.SkipDir
			} else {
				name := strings.SplitAfterN(path, "/", 6)
				name = strings.SplitAfterN(name[5], "/", 2)

				if len(name) == 1 {
					directories["."] = absPath
				} else {
					directories[name[1]] = absPath + "/" + name[1]
				}

			}
		}
		return nil
	})

	if err != nil {
		log.Printf("Error walking the path: [%v]", err)
	}

	return directories
}

// Convert directory names to a list of `huh.Option` so they can be used in `huh.NewSelect`
// In the `getDirectories` function we stored each directory name and its path inside a map,
// which makes it very easy to create a new `huh.Option` with the directory name as the
// visible part and it's full path as the value we get when we select the option.
func convertDirToOpt(dirs map[string]string) []huh.Option[string] {
	if len(dirs) == 0 {
		return nil
	}

	items := []huh.Option[string]{}

	// Sort the map
	keys := make([]string, 0, len(dirs))

	for k := range dirs {
		keys = append(keys, k)
	}

	sort.Strings(keys)

	for _, k := range keys {
		items = append(items, huh.NewOption(k, dirs[k]))
	}

	return items
}

// Create the form
func createHuhForm(opts []huh.Option[string]) (string, string, string) {
	var file, dir, newDir string

	form := huh.NewForm(
		huh.NewGroup(
			huh.NewInput().Title("What should the new note be called?").
				Value(&file).
				Validate(func(str string) error {
					if len(str) == 0 {
						return errors.New("New note name cannot be empty!")
					}
					return nil
				}),
			huh.NewInput().Title("Create a new directory to store the note to").
				Description("If a directory is selected in the next list, the new directory will be created under it").
				Value(&newDir),
			huh.NewSelect[string]().Title("Where should the new note be saved to?").
				Options(opts...).
				Value(&dir),
		),
	)

	err := form.Run()
	if err != nil {
		log.Fatalf("Could not run the form: %v", err)
	}

	return file, dir, newDir
}

// Open file in Neovim
func openFile(file, dir string) {
	cmd := exec.Command("nvim", "+ normal ggzz", dir+"/"+file+".md")
	cmd.Stdin = os.Stdin
	cmd.Stdout = os.Stdout

	err := cmd.Run()
	if err != nil {
		log.Fatalf("Error opening file: %v", err)
	}
}
