Setup a repository
  ```
  cd ~/
  mkdir repository_name.git
  git init --bare
  ```

link to a local git repository
  ```
  git init
  git remote add origin ~/seo_potato.git
  ```

link to a remote repository
  ```
  git init
  git remote add origin ubuntu@ec2-204-236-242-99.compute-1.amazonaws.com:seo_potato.git
  ```

To check git repository information
  ```
  ./.git/config
  ```

To checkout existing branch to a new branch
  ```
  git checkout -B new_branch_name
  ```

To checkout current commit from master to a new branch
  ```
  git cherry-pick COMMIT_HASH
  ```

Configuration for colors
  ```
  in ~/.gitconfig

  add the following lines

  [color]
    ui = always
  [color "branch"]
    current = yellow reverse
    local = yellow
    remote = green
  [color "diff"]
    meta = yellow bold
    frag = magenta bold
    old = red bold
    new = green bold
  [color "status"]
    added = yellow
    changed = green
    untracked = cyan
  ```

Extending it
  ```
  https://github.com/nojhan/liquidprompt
  ```

Authentication
  ```
  # Within the project
  git config credential.helper store

  # Gobally
  git config --global credential.helper store

  # Within project when there are multiple git accounts associated with multiple git repositories on your dev box
  git config --local core.sshCommand "/usr/bin/ssh -i /home/me/.ssh/id_rsa_foo"
  ```

Verbose trouble shooting
  in ~/.ssh/config
  ```
  Host github.com
    LogLevel DEBUG3
  ```

Setting up multiple github accounts for different repositories on the same machine

- Step 1: create a new SSH Key pair - make sure not to override your existing key pairs
  ```
  cd ~/.ssh
  ssh-keygen -t rsa -C "your_email@youremail.com"
  ```

- Step 2: add private key to your local keychain
  ```
   ssh-add ~/.ssh/your_github_private_key
   ```

- Step 3: check to make sure your key was added
  ```
  ssh-add -l
  ```

- Step 4: setup your SSH configuration - ~/.ssh/config
  ```
  Host github.com-YOUR_GITHUB_USERNAME
    HostName github.com
    User git
    IdentityFile ~/.ssh/your_github_private_key
  ```

- Step 5: Add your newly generated public key to your GitHub.com account

- Step 6: edit the configurations of your current github repository
  PATH_TO_YOUR_REPO/.git/config

  User section
  ```
  [user]
    email = YOUR_GITHUB_EMAIL_ADDRESS
    name = YOUR_GITHUB_USERNAME
  ```

  Remote origin
  ```
  [remote "origin"]
    url = git@github.com-YOUR_GITHUB_USERNAME:garyjob/Setup-Wiki.git
  ```

- Step 7: Troubleshooting your github transactions
  in ~/.ssh/config
  ```
  Host github.com
    LogLevel DEBUG3
  ```