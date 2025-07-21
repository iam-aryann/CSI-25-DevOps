# Week 7: Azure DevOps

## Overview
This week focuses on mastering Azure DevOps Repos, Pipelines, Policies, and Security to enhance project governance, code integrity, collaboration, and automation in a team-based environment. Each task builds skills in managing repositories, automating CI/CD pipelines, enforcing policies, and ensuring traceability.

---

## Tasks Overview

| **Task** | **Topic** | **Description** |
|----------|-----------|-----------------|
| **1** | Create a Project with User Groups and Policies | Created a project, added user groups (e.g., Admins, Contributors, Readers), and applied group-based permission policies. |
| **2** | Branch Policies for Master Access | Configured policies to restrict direct pushes to `master` to Project Administrators, allowing Contributors to use pull requests only. |
| **3** | Branch Security and Locks | Applied security roles to branches and locked `master` to prevent accidental commits or merges. |
| **4** | Branch and Path Filters | Used branch filters to trigger pipelines on specific branches (e.g., `main`, `develop`) and path filters for specific file changes. |
| **5** | Apply a Pull Request | Created a feature branch, made changes, and raised a pull request for code review and merging. |
| **6** | Branch Policy and Security | Enforced reviewer requirements, blocked direct pushes to `master`, and required status checks for PRs. |
| **7** | Triggers in Build and Release | Configured CI triggers for builds on code push and CD triggers for deployments on successful builds. |
| **8** | Gates in Pipelines | Added gates (e.g., Azure Monitor Alerts) to release pipelines to enforce preconditions before stage promotion. |
| **9** | Branch Security for PRs Only | Set permissions to allow Contributors to create PRs but deny direct pushes or merges to `master`. |
| **10** | Work Items in Pipelines | Linked work items (e.g., tasks, user stories) to commits and pipelines for end-to-end traceability. |

---

## Resources
- [Microsoft Docs: Add Users to Team Projects](https://learn.microsoft.com/azure/devops/organizations/security/add-users-team-project?view=azure-devops)
- [Microsoft Docs: Branch Policies and Permissions](https://learn.microsoft.com/azure/devops/repos/git/branch-policies?view=azure-devops)
- [Microsoft Docs: Pull Requests](https://learn.microsoft.com/azure/devops/repos/git/pull-requests?view=azure-devops)
- [Microsoft Docs: Build Triggers](https://learn.microsoft.com/azure/devops/pipelines/build/triggers?view=azure-devops)
- [Microsoft Docs: Pipeline Gates](https://learn.microsoft.com/azure/devops/pipelines/release/gates?view=azure-devops)
- [Microsoft Docs: Work Items in Azure Boards](https://learn.microsoft.com/azure/devops/boards/work-items/about-work-items?view=azure-devops)
- [YouTube: Azure DevOps Tutorials](https://www.youtube.com/results?search_query=azure+devops+tutorial)

---

## Learning Outcomes
- Mastered Azure DevOps for project setup, user management, and permission policies.
- Configured secure and controlled workflows using branch policies and security settings.
- Implemented pull requests to enforce code reviews and maintain code quality.
- Automated CI/CD pipelines with triggers and gates for efficient deployments.
- Achieved traceability by linking work items to commits and pipeline runs.
