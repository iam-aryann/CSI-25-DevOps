# Week 8: Azure DevOps II
## Task 1: Configure Dashboard and Queries for Work Items

**Objective**:  
Set up dashboards to visualize project metrics and create queries to filter, track, and manage work items in Azure DevOps for enhanced project oversight.

---

## Prerequisites
- An Azure DevOps organization and project (e.g., from Week 7, Task 1).
- Basic access level or higher in the project.
- Existing work items (e.g., Epics, User Stories, Tasks, Bugs) in Azure Boards.
- Permissions to create queries and edit dashboards.

---

## Step-by-Step Guide

### Part A: Configure Queries for Work Items
1. **Navigate to Boards > Queries**:
   - In your Azure DevOps project, go to **Boards** > **Queries** from the left menu.

2. **Create a New Query**:
   - Click **New Query**.
   - Define conditions. Example:
     - **Work Item Type** = `Task`
     - **State** = `Active`
     - **Assigned To** = `@Me` (filters tasks assigned to the current user).
   - Click **Run Query** to view results.

3. **Save the Query**:
   - Click **Save As**.
   - Enter a name (e.g., `My Active Tasks`).
   - Select a folder (e.g., `Shared Queries` or `My Queries`).
   - (Optional) Set permissions to **Private** or **Shared** for team access.
   - Click **Save**.

4. **Pin Query Results to Dashboard (Optional)**:
   - After saving, click the ellipsis (**...**) next to the query.
   - Select **Pin to Dashboard**.
   - Choose the target dashboard and tile type (e.g., **List** or **Chart**).

---

### Part B: Configure Dashboards
1. **Go to Dashboards**:
   - From the left menu, select **Dashboards**.
   - Choose an existing dashboard or click **Create Dashboard** to make a new one (e.g., name it `Project Overview`).

2. **Add Widgets to Visualize Work Items**:
   - Click **Edit** on the dashboard.
   - Click **+ Add a Widget** and select:
     - **Query Tile**: Displays the count of query results (e.g., `My Active Tasks`).
     - **Chart for Work Items**: Shows graphical data (e.g., bar or pie chart for query results).
     - **Sprint Burndown**: Tracks progress in the current sprint (if using sprints).
   - Configure each widget by linking it to a saved query (e.g., `My Active Tasks`).
   - Example: For a **Chart for Work Items**, select a query and choose a chart type (e.g., **Pie Chart** grouped by **State**).

3. **Customize Dashboard Layout**:
   - Drag and drop widgets to rearrange them.
   - Resize or reposition widgets as needed.
   - Click **Save** to finalize the dashboard.

---

## Example Use Cases
| **Use Case** | **Query Example** | **Widget Type** |
|--------------|-------------------|-----------------|
| Track user’s tasks | Assigned To = @Me, State = Active | List/Query Tile |
| See bugs in current iteration | Iteration Path = Current, Work Item Type = Bug | Pie/Bar Chart |
| Count of resolved work items | State = Resolved | Query Tile |
| Burn-down for sprint | Iteration Path = Current | Sprint Burndown Chart |

---

## References
- [Microsoft Docs: Work Item Queries](https://learn.microsoft.com/azure/devops/boards/queries/using-queries?view=azure-devops)
- [How to Create a CI/CD Pipeline in Azure DevOps | Azure DevOps Tutorial
](https://www.youtube.com/watch?v=xH5EY7FCFQw&t=77s)
- [Microsoft Docs: Azure DevOps Dashboards](https://learn.microsoft.com/azure/devops/project/dashboards/dashboards?view=azure-devops)
