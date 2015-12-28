## Website Tech Details (git remote & submodule)
-- clone gh-pages branch to local
$ git clone -b <branch-name> <repo-url> <local-repo-name>
-- init submodule repo (after clone)
$ cd <sub-module-name>
$ git init

-- add submodule to a local repo
$ git submodule add <sub-module-repo-url> <sub-module-repo-name>

-- after making some changes in submodule remote
-- update sub-module
$ git pull

-- push changes from gh-pages local to remote
$ git push origin HEAD:gh-pages

-- serve jekyll with baseurl
$ jekyll serve —baseurl “/<baseurl>/"

-- git remote
https://help.github.com/articles/adding-an-existing-project-to-github-using-the-command-line/#platform-mac
https://git-scm.com/book/en/v2/Git-Basics-Working-with-Remotes
http://stackoverflow.com/questions/1519006/how-do-you-create-a-remote-git-branch

-- git submodule
http://git-scm.com/book/en/v2/Git-Tools-Submodules
https://github.com/iluwatar/java-design-patterns/wiki/07.-Working-with-the-web-site
