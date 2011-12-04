name "gitlab"
description "GitLab Web App"

run_list(
  "recipe[base_packages]",
  "recipe[rvm::system]",
  "recipe[rvm::vagrant]",
  "recipe[vagrant]",
  "recipe[pygments]",
  "recipe[gitosis]",
  "recipe[gitlab]"
)
