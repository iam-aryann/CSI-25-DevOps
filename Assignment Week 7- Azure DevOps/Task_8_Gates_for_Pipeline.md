## Task 8: Apply Gates to the Pipeline

**Objective**:  
Add gates to a release pipeline in Azure DevOps to enforce automated checks (e.g., Azure Monitor alerts, work item queries) before promoting a deployment to the next stage, ensuring quality and compliance.

---

## Prerequisites
- An Azure DevOps project with a Git repository and a release pipeline (e.g., from Week 7, Task 7).
- A release pipeline with at least two stages (e.g., `Dev` → `QA`).
- Administrative permissions to edit release pipelines and configure gates.
- Optional: An Azure Monitor alert rule or work items set up for testing gate conditions.

---

## What are Gates?
Gates are automated checks in a release pipeline that evaluate external conditions before allowing a deployment to proceed to the next stage. They can:
- Call REST APIs.
- Query Azure Monitor alerts.
- Invoke Azure Functions.
- Check work item states.

---

## Steps to Apply Gates

1. **Navigate to Release Pipeline**:
   - Go to **Pipelines** > **Releases** in your Azure DevOps project.
   - Select an existing release pipeline with at least two stages (e.g., `Dev` and `QA`).

2. **Configure Pre-deployment Conditions**:
   - Click the **Pre-deployment conditions** ⚙️ icon for the `QA` stage.
   - Scroll to the **Gates** section and toggle **Gates** to **ON**.

3. **Add a Gate**:
   - Click **+ Add** and select a gate type, such as:
     - **Query Azure Monitor Alerts**: Checks for active alerts in a resource group.
     - **Query Work Items**: Ensures specific work items (e.g., bugs) are resolved.
     - **Invoke Azure Function** or **Invoke REST API**: For custom logic.
   - **Example (Azure Monitor Alerts)**:
     - Select **Query Azure Monitor Alerts**.
     - Configure:
       - **Azure Subscription**: Select your subscription.
       - **Resource Group**: Choose the relevant resource group.
       - **Alert Rule**: Select an existing alert rule (e.g., CPU usage alert).
       - **Evaluation Interval**: Set to 5 minutes.
       - **Timeout**: Set to 30 minutes.
       - **Minimum Successful Evaluations**: Set to 1 (requires at least one successful check).

4. **Save the Pipeline**:
   - Click **Save** to apply the gate configuration.

5. **Test the Gate**:
   - Create a new release or trigger a build to initiate the pipeline.
   - Monitor the release in the **Releases** view to see the gate evaluation status (e.g., pending, succeeded, or failed).

---

## Resources
- [YouTube: Azure DevOps Repos & Gates](https://www.youtube.com/results?search_query=azure+devops+gates)
- [Getting Started with Azure DevOps Repos
](https://www.youtube.com/watch?v=qLhVWJvox7g)
- [Microsoft Docs: Gates in Release Pipelines](https://learn.microsoft.com/azure/devops/pipelines/release/gates?view=azure-devops)
