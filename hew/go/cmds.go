package main

import (
	"fmt"
	"log"
	"os"
	"strconv"
	"time"

	"golang.org/x/term"

	"github.com/charmbracelet/bubbles/list"
	"github.com/charmbracelet/bubbles/table"
	"github.com/charmbracelet/lipgloss"
	"github.com/spf13/cobra"
)

func BuildCmdTree() *cobra.Command {
	var rootCmd = &cobra.Command{
		Use:   "tasks",
		Short: "A CLI task management tool for ~slaying~ your to do list.",
		Args:  cobra.NoArgs,
		RunE:  taskRoot,
	}

	var addCmd = &cobra.Command{
		Use:   "add NAME",
		Short: "Add a new task with an optional project name",
		Args:  cobra.ExactArgs(1),
		RunE:  taskAdd,
	}
	addCmd.Flags().StringP("project", "p", "", "specify a project for your task")
	rootCmd.AddCommand(addCmd)

	var listCmd = &cobra.Command{
		Use:   "list",
		Short: "List all your tasks",
		Args:  cobra.NoArgs,
		RunE:  taskList,
	}
	rootCmd.AddCommand(listCmd)

	var updateCmd = &cobra.Command{
		Use:   "update ID",
		Short: "Update a task by ID",
		Args:  cobra.ExactArgs(1),
		RunE:  taskUpdate,
	}
	updateCmd.Flags().StringP("name", "n", "", "specify a name for your task")
	updateCmd.Flags().StringP("project", "p", "", "specify a project for your task")
	updateCmd.Flags().IntP("status", "s", int(todo), "specify a status for your task")
	rootCmd.AddCommand(updateCmd)

	// task delete command
	var deleteCmd = &cobra.Command{
		Use:   "delete ID",
		Short: "Delete a task by ID",
		Args:  cobra.ExactArgs(1),
		RunE:  taskDelete,
	}
	rootCmd.AddCommand(deleteCmd)

	return rootCmd
}

func taskRoot(cmd *cobra.Command, args []string) error {
	return cmd.Help()
}

func taskAdd(cmd *cobra.Command, args []string) error {
	project, err := cmd.Flags().GetString("project")
	if err != nil {
		return err
	}
	fmt.Printf("%+v, %+v", args[0], project)
	if err := taskDb.insertTask(args[0], project); err != nil {
		return err
	}
	return nil
}

func taskList(cmd *cobra.Command, args []string) error {
	//tasks, err := t.getTasks()
	//if err != nil {
	// return err
	//}
	//table := setupTable(tasks)
	//fmt.Print(table.View())
	return nil
}

func taskUpdate(cmd *cobra.Command, args []string) error {
	name, err := cmd.Flags().GetString("name")
	if err != nil {
		return err
	}
	project, err := cmd.Flags().GetString("project")
	if err != nil {
		return err
	}
	prog, err := cmd.Flags().GetInt("status")
	if err != nil {
		return err
	}
	id, err := strconv.Atoi(args[0])
	if err != nil {
		return err
	}
	fmt.Printf("%+v", id)
	var status string
	switch prog {
	case int(inProgress):
		status = inProgress.String()
	case int(done):
		status = done.String()
	default:
		status = todo.String()
	}
	newTask := task{Name: name, Project: project, Status: status, Created: time.Time{}}
	fmt.Printf("%+v", newTask)
	return nil //TODO: t.update(newTask)
}

func taskDelete(cmd *cobra.Command, args []string) error {
	id, err := strconv.Atoi(args[0])
	if err != nil {
		return err
	}
	fmt.Printf("%+v", id)
	return nil //TODO: t.delete(uint(id))
}

func calculateWidth(min, width int) int {
	p := width / 10
	switch min {
	case XS:
		if p < XS {
			return XS
		}
		return p / 2

	case SM:
		if p < SM {
			return SM
		}
		return p / 2
	case MD:
		if p < MD {
			return MD
		}
		return p * 2
	case LG:
		if p < LG {
			return LG
		}
		return p * 3
	default:
		return p
	}
}

const (
	XS int = 1
	SM int = 3
	MD int = 5
	LG int = 10
)

func setupTable(tasks []task) table.Model {
	// get term size
	w, _, err := term.GetSize(int(os.Stdout.Fd()))
	if err != nil {
		// we don't really want to fail it...
		log.Println("unable to calculate height and width of terminal")
	}

	columns := []table.Column{
		{Title: "ID", Width: calculateWidth(XS, w)},
		{Title: "Name", Width: calculateWidth(LG, w)},
		{Title: "Project", Width: calculateWidth(MD, w)},
		{Title: "Status", Width: calculateWidth(SM, w)},
		{Title: "Created At", Width: calculateWidth(MD, w)},
	}
	var rows []table.Row
	for _, task := range tasks {
		rows = append(rows, table.Row{
			fmt.Sprintf("%d", task.ID),
			task.Name,
			task.Project,
			task.Status,
			task.Created.Format("2006-01-02"),
		})
	}
	t := table.New(
		table.WithColumns(columns),
		table.WithRows(rows),
		table.WithFocused(false),
		table.WithHeight(len(tasks)),
	)
	s := table.DefaultStyles()
	s.Header = s.Header.
		BorderStyle(lipgloss.NormalBorder()).
		BorderForeground(lipgloss.Color("240")).
		BorderBottom(true).
		Bold(false)
	t.SetStyles(s)
	return t
}

// convert tasks to items for a list
func tasksToItems(tasks []task) []list.Item {
	var items []list.Item
	for _, t := range tasks {
		items = append(items, t)
	}
	return items
}
