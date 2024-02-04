package main

import (
	"errors"
	"log"
	"os"
	"os/exec"
	"path/filepath"
	"sort"

	"github.com/charmbracelet/huh"
)

const notesDir = "/Documents/Syncthing/Obsidian_Vault"

func main() {
	directories := getDirectories()

	opts := convertDirToOpt(directories)

	note, dir := createHuhForm(opts)

	openFile(note, dir)
}

// Get all the directories under my notes directory.
func getDirectories() map[string]string {
	homeDir, err := os.UserHomeDir()
	if err != nil {
		log.Fatalf("Could not get user's home directory: %v", err)
	}

	entries, err := os.ReadDir(homeDir + notesDir)
	if err != nil {
		log.Fatalf("Could not read directories in notesDir: %v", err)
	}

	directories := make(map[string]string)
	var absPath string

	// Store the root directory
	absPath, _ = filepath.Abs(homeDir + notesDir)
	directories["."] = absPath

	for _, e := range entries {
		// Store non-hidden directories in a map where the key is the directory name and the value is its full path on the disk
		if e.IsDir() && e.Name()[0] != '.' {
			absPath, _ = filepath.Abs(homeDir + notesDir)
			directories[e.Name()] = absPath + "/" + e.Name()
		}
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
func createHuhForm(opts []huh.Option[string]) (string, string) {
	var file, dir string

	form := huh.NewForm(
		huh.NewGroup(
			huh.NewInput().Title("What should the new note be called?").Value(&file).Validate(func(str string) error {
				if len(str) == 0 {
					return errors.New("New note name cannot be empty!")
				}
				return nil
			}),
			huh.NewSelect[string]().Title("Where should the new note be saved to?").Options(opts...).Value(&dir),
		),
	)

	err := form.Run()
	if err != nil {
		log.Fatalf("Could not run the form: %v", err)
	}

	return file, dir
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
