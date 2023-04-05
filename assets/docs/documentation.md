# Generate folder command - feature_folder_cli package
ff generate -n <feature_name> -t <type>

## How does it work?
Domain → Models — contains all the data models and JSON to/from Dart helper functions
Domain → Repository — contains abstract classes that describe the feature functionality
Domain → Services — contains the actual implementation of the repository
Providers — contains everything related to the state for that particular feature
Screens — contains full screens that have a Scaffold
Widgets — contains all the widgets required for that particular feature

------------------------

# Git flow 

checkout new branch
push to github
commit changes
push changes
create PR
merge PR
delete branch
git pull in master branch
delte old branch - git branch -d <local-branch>
git fetch --prune