name "gitlab"
description "GitLab Web App"

run_list(
  "recipe[base_packages]",
  "recipe[nginx]",
  "recipe[rvm::system]",
  "recipe[rvm::vagrant]",
  "recipe[vagrant]",
  "recipe[pygments]",
  "recipe[gitosis]",
  "recipe[gitlab]",
  "recipe[gitlab::nginx]"
)
