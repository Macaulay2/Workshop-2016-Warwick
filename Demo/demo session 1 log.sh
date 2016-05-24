einsteinium$ cd /tmp
einsteinium$ mkdir demo
einsteinium$ cd demo
einsteinium$ git clone git@github.com:Macaulay2/Workshop-2016-Warwick.git
Cloning into 'Workshop-2016-Warwick'...
remote: Counting objects: 32, done.        
remote: Compressing objects:   4% (1/22)           remote: Compressing objects:   9% (2/22)           remote: Compressing objects:  13% (3/22)           remote: Compressing objects:  18% (4/22)           remote: Compressing objects:  22% (5/22)           remote: Compressing objects:  27% (6/22)           remote: Compressing objects:  31% (7/22)           remote: Compressing objects:  36% (8/22)           remote: Compressing objects:  40% (9/22)           remote: Compressing objects:  45% (10/22)           remote: Compressing objects:  50% (11/22)           remote: Compressing objects:  54% (12/22)           remote: Compressing objects:  59% (13/22)           remote: Compressing objects:  63% (14/22)           remote: Compressing objects:  68% (15/22)           remote: Compressing objects:  72% (16/22)           remote: Compressing objects:  77% (17/22)           remote: Compressing objects:  81% (18/22)           remote: Compressing objects:  86% (19/22)           remote: Compressing objects:  90% (20/22)           remote: Compressing objects:  95% (21/22)           remote: Compressing objects: 100% (22/22)           remote: Compressing objects: 100% (22/22), done.        
Receiving objects:   3% (1/32)   Receiving objects:   6% (2/32)   Receiving objects:   9% (3/32)   Receiving objects:  12% (4/32)   Receiving objects:  15% (5/32)   Receiving objects:  18% (6/32)   Receiving objects:  21% (7/32)   Receiving objects:  25% (8/32)   Receiving objects:  28% (9/32)   Receiving objects:  31% (10/32)   Receiving objects:  34% (11/32)   remote: Total 32 (delta 4), reused 32 (delta 4), pack-reused 0        
Receiving objects:  37% (12/32)   Receiving objects:  40% (13/32)   Receiving objects:  43% (14/32)   Receiving objects:  46% (15/32)   Receiving objects:  50% (16/32)   Receiving objects:  53% (17/32)   Receiving objects:  56% (18/32)   Receiving objects:  59% (19/32)   Receiving objects:  62% (20/32)   Receiving objects:  65% (21/32)   Receiving objects:  68% (22/32)   Receiving objects:  71% (23/32)   Receiving objects:  75% (24/32)   Receiving objects:  78% (25/32)   Receiving objects:  81% (26/32)   Receiving objects:  84% (27/32)   Receiving objects:  87% (28/32)   Receiving objects:  90% (29/32)   Receiving objects:  93% (30/32)   Receiving objects:  96% (31/32)   Receiving objects: 100% (32/32)   Receiving objects: 100% (32/32), 72.35 KiB | 0 bytes/s, done.
Resolving deltas:   0% (0/4)   Resolving deltas:  50% (2/4)   Resolving deltas:  75% (3/4)   Resolving deltas: 100% (4/4)   Resolving deltas: 100% (4/4), done.
Checking connectivity... done.
einsteinium$ ls
Workshop-2016-Warwick
einsteinium$ cd Workshop-2016-Warwick/
einsteinium$ ls
InformativePDFs  README.md  RandomIdeals
einsteinium$ git status
On branch master
Your branch is up-to-date with 'origin/master'.
Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git checkout -- <file>..." to discard changes in working directory)

	modified:   README.md

no changes added to commit (use "git add" and/or "git commit -a")
einsteinium$ git diff
diff --git a/README.md b/README.md
index 42c9f5f..055b0c6 100644
--- a/README.md
+++ b/README.md
@@ -10,3 +10,5 @@ Collaboration area for the Macaulay2 workshop at the University of Warwick, May
 - The other package, ResidualIntersection.m2, contains tests for many of the special properties of Cohen-Macaulay ideals that have been used in the theory of residual intersections; things such as "strongly Cohen-Macaulay" and "sliding depth" and "G_d"
 
 - Eisenbud hopes to use these two packages together to construct interesting new families of square-free monomial ideals for which these strong Cohen-Macaulay properties hold, and to try in this way to understand them combinatorially.
+
+- Dan Grayson adds something to this file
einsteinium$ git add README.md 
einsteinium$ git status
On branch master
Your branch is up-to-date with 'origin/master'.
Changes to be committed:
  (use "git reset HEAD <file>..." to unstage)

	modified:   README.md

einsteinium$ git commit
Waiting for Emacs...
[master 54a58c5] Dan changed a file
 1 file changed, 2 insertions(+)
einsteinium$ git status
On branch master
Your branch is ahead of 'origin/master' by 1 commit.
  (use "git push" to publish your local commits)
nothing to commit, working directory clean
einsteinium$ git push
Counting objects: 3, done.
Delta compression using up to 8 threads.
Compressing objects:  33% (1/3)   Compressing objects:  66% (2/3)   Compressing objects: 100% (3/3)   Compressing objects: 100% (3/3), done.
Writing objects:  33% (1/3)   Writing objects:  66% (2/3)   Writing objects: 100% (3/3)   Writing objects: 100% (3/3), 403 bytes | 0 bytes/s, done.
Total 3 (delta 1), reused 0 (delta 0)
To git@github.com:Macaulay2/Workshop-2016-Warwick.git
   e9dbcd8..54a58c5  master -> master
einsteinium$ mkdir Demo
einsteinium$ ls
Demo  InformativePDFs  README.md  RandomIdeals
einsteinium$ cd Demo
einsteinium$ git status
On branch master
Your branch is up-to-date with 'origin/master'.
Untracked files:
  (use "git add <file>..." to include in what will be committed)

	./

nothing added to commit but untracked files present (use "git add" to track)
einsteinium$ ls
README
einsteinium$ git add README 
einsteinium$ git status
On branch master
Your branch is up-to-date with 'origin/master'.
Changes to be committed:
  (use "git reset HEAD <file>..." to unstage)

	new file:   README

einsteinium$ git commit
Waiting for Emacs...
[master 4a70a65] add a file
 1 file changed, 1 insertion(+)
 create mode 100644 Demo/README
einsteinium$ git status
On branch master
Your branch is ahead of 'origin/master' by 1 commit.
  (use "git push" to publish your local commits)
nothing to commit, working directory clean
einsteinium$ git log 
commit 4a70a65f41e01a307dd99cafe5ed12411a148da5
Author: Daniel R. Grayson <dan@math.uiuc.edu>
Date:   Mon May 23 09:20:58 2016 +0100

    add a file

commit 54a58c5bc9abb88b141a3d9b9bc47d4c07e1ba5a
Author: Daniel R. Grayson <dan@math.uiuc.edu>
Date:   Mon May 23 09:18:50 2016 +0100

    Dan changed a file

commit e9dbcd88c03a4ea9a40b7031854b417468a2d9b8
Author: Thomas Kahle <thomas.kahle@jpberlin.de>
Date:   Sun May 22 12:59:01 2016 +0200

    Bring back intro to packages.

commit ef3abcc55fc343143413cf2972971de322958c02
Author: eisenbud <eisenbud@users.noreply.github.com>
Date:   Thu May 19 20:02:22 2016 -0700

    Create README.md

commit aa8e1ac235c206f83796454d7e51e00d2aea34b4
Author: David Eisenbud <de@msri.org>
Date:   Thu May 19 19:47:07 2016 -0700

    set up a directory for Warwick with materials created in Utah

commit d27b547692ec6e5344e3e1560208a430d713d647
Author: Thomas Kahle <thomas.kahle@jpberlin.de>
Date:   Tue Apr 12 19:15:13 2016 +0200

    Update README.md

commit 98f7887ed725afcdcadcdab282163dd68d5897aa
Author: Thomas Kahle <thomas.kahle@jpberlin.de>
Date:   Tue Apr 12 18:59:35 2016 +0200

    cleanup

commit 968fc97ac9380af43348d8ec968d452ee37b5891
Author: Thomas Kahle <thomas.kahle@jpberlin.de>
Date:   Tue Apr 12 18:59:17 2016 +0200

    add pdf about packages

commit 3f00093e7c8345a8f8cb28ab67385b82fffcd36e
Author: Thomas Kahle <thomas.kahle@jpberlin.de>
Date:   Tue Apr 12 17:55:27 2016 +0200

    Add a category

commit 6baa74bc1ac4f33ecf1aacf56d7802dab9d0075c
Author: Thomas Kahle <thomas.kahle@jpberlin.de>
Date:   Tue Apr 12 11:00:32 2016 +0200

    Welcome

commit 0d42aa996828517a8e65f17566b6e4a0ba4d4ae9
Author: Daniel R. Grayson <dan@math.uiuc.edu>
Date:   Tue Mar 29 21:26:07 2016 -0500

    Initial commit
einsteinium$ git push
Counting objects: 4, done.
Delta compression using up to 8 threads.
Compressing objects:  50% (1/2)   Compressing objects: 100% (2/2)   Compressing objects: 100% (2/2), done.
Writing objects:  25% (1/4)   Writing objects:  50% (2/4)   Writing objects:  75% (3/4)   Writing objects: 100% (4/4)   Writing objects: 100% (4/4), 353 bytes | 0 bytes/s, done.
Total 4 (delta 1), reused 0 (delta 0)
To git@github.com:Macaulay2/Workshop-2016-Warwick.git
   54a58c5..4a70a65  master -> master
einsteinium$ git pull
Already up-to-date.
einsteinium$ pwd
/tmp/demo/Workshop-2016-Warwick/Demo
einsteinium$ cd ..
einsteinium$ pwd
/tmp/demo/Workshop-2016-Warwick
einsteinium$ cd ..
einsteinium$ ls
Workshop-2016-Warwick
einsteinium$ git clone git@github.com:Macaulay2/Workshop-2016-Warwick.git Workshop-2016-Warwick-2
Cloning into 'Workshop-2016-Warwick-2'...
remote: Counting objects: 43, done.        
remote: Compressing objects:   3% (1/29)           remote: Compressing objects:   6% (2/29)           remote: Compressing objects:  10% (3/29)           remote: Compressing objects:  13% (4/29)           remote: Compressing objects:  17% (5/29)           remote: Compressing objects:  20% (6/29)           remote: Compressing objects:  24% (7/29)           remote: Compressing objects:  27% (8/29)           remote: Compressing objects:  31% (9/29)           remote: Compressing objects:  34% (10/29)           remote: Compressing objects:  37% (11/29)           remote: Compressing objects:  41% (12/29)           remote: Compressing objects:  44% (13/29)           remote: Compressing objects:  48% (14/29)           remote: Compressing objects:  51% (15/29)           remote: Compressing objects:  55% (16/29)           remote: Compressing objects:  58% (17/29)           remote: Compressing objects:  62% (18/29)           remote: Compressing objects:  65% (19/29)           remote: Compressing objects:  68% (20/29)           remote: Compressing objects:  72% (21/29)           remote: Compressing objects:  75% (22/29)           remote: Compressing objects:  79% (23/29)           remote: Compressing objects:  82% (24/29)           remote: Compressing objects:  86% (25/29)           remote: Compressing objects:  89% (26/29)           remote: Compressing objects:  93% (27/29)           remote: Compressing objects:  96% (28/29)           remote: Compressing objects: 100% (29/29)           remote: Compressing objects: 100% (29/29), done.        
Receiving objects:   2% (1/43)   Receiving objects:   4% (2/43)   Receiving objects:   6% (3/43)   Receiving objects:   9% (4/43)   Receiving objects:  11% (5/43)   Receiving objects:  13% (6/43)   Receiving objects:  16% (7/43)   Receiving objects:  18% (8/43)   Receiving objects:  20% (9/43)   Receiving objects:  23% (10/43)   Receiving objects:  25% (11/43)   Receiving objects:  27% (12/43)   Receiving objects:  30% (13/43)   Receiving objects:  32% (14/43)   Receiving objects:  34% (15/43)   Receiving objects:  37% (16/43)   Receiving objects:  39% (17/43)   Receiving objects:  41% (18/43)   Receiving objects:  44% (19/43)   Receiving objects:  46% (20/43)   Receiving objects:  48% (21/43)   remote: Total 43 (delta 7), reused 41 (delta 5), pack-reused 0        
Receiving objects:  51% (22/43)   Receiving objects:  53% (23/43)   Receiving objects:  55% (24/43)   Receiving objects:  58% (25/43)   Receiving objects:  60% (26/43)   Receiving objects:  62% (27/43)   Receiving objects:  65% (28/43)   Receiving objects:  67% (29/43)   Receiving objects:  69% (30/43)   Receiving objects:  72% (31/43)   Receiving objects:  74% (32/43)   Receiving objects:  76% (33/43)   Receiving objects:  79% (34/43)   Receiving objects:  81% (35/43)   Receiving objects:  83% (36/43)   Receiving objects:  86% (37/43)   Receiving objects:  88% (38/43)   Receiving objects:  90% (39/43)   Receiving objects:  93% (40/43)   Receiving objects:  95% (41/43)   Receiving objects:  97% (42/43)   Receiving objects: 100% (43/43)   Receiving objects: 100% (43/43), 73.27 KiB | 0 bytes/s, done.
Resolving deltas:   0% (0/7)   Resolving deltas:  14% (1/7)   Resolving deltas:  28% (2/7)   Resolving deltas:  57% (4/7)   Resolving deltas:  85% (6/7)   Resolving deltas: 100% (7/7)   Resolving deltas: 100% (7/7), done.
Checking connectivity... done.
einsteinium$ ls
Workshop-2016-Warwick  Workshop-2016-Warwick-2
einsteinium$ cd Workshop-2016-Warwick-2/
einsteinium$ git status
On branch master
Your branch is ahead of 'origin/master' by 1 commit.
  (use "git push" to publish your local commits)
Untracked files:
  (use "git add <file>..." to include in what will be committed)

	Demo/#README#
	Demo/.#README

nothing added to commit but untracked files present (use "git add" to track)
einsteinium$ cd Workshop-2016-Warwick-2/
bash: cd: Workshop-2016-Warwick-2/: No such file or directory
einsteinium$ git status
On branch master
Your branch is ahead of 'origin/master' by 1 commit.
  (use "git push" to publish your local commits)
Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git checkout -- <file>..." to discard changes in working directory)

	modified:   Demo/README

no changes added to commit (use "git add" and/or "git commit -a")
einsteinium$ git diff
diff --git a/Demo/README b/Demo/README
index c5e0d46..59bf965 100644
--- a/Demo/README
+++ b/Demo/README
@@ -3,3 +3,5 @@ This file is in a directory that Dan made.
 I made a change.
 
 Add a line.
+
+In emacs I used C-x v v to 
\ No newline at end of file
einsteinium$ git status
On branch master
Your branch is ahead of 'origin/master' by 2 commits.
  (use "git push" to publish your local commits)
nothing to commit, working directory clean
einsteinium$ git push
To git@github.com:Macaulay2/Workshop-2016-Warwick.git
 ! [rejected]        master -> master (fetch first)
error: failed to push some refs to 'git@github.com:Macaulay2/Workshop-2016-Warwick.git'
hint: Updates were rejected because the remote contains work that you do
hint: not have locally. This is usually caused by another repository pushing
hint: to the same ref. You may want to first integrate the remote changes
hint: (e.g., 'git pull ...') before pushing again.
hint: See the 'Note about fast-forwards' in 'git push --help' for details.
einsteinium$ git pull
remote: Counting objects: 6, done.        
remote: Compressing objects:  50% (1/2)           remote: Compressing objects: 100% (2/2)           remote: Compressing objects: 100% (2/2), done.        
remote: Total 6 (delta 3), reused 6 (delta 3), pack-reused 0        
Unpacking objects:  16% (1/6)   Unpacking objects:  33% (2/6)   Unpacking objects:  50% (3/6)   Unpacking objects:  66% (4/6)   Unpacking objects:  83% (5/6)   Unpacking objects: 100% (6/6)   Unpacking objects: 100% (6/6), done.
From github.com:Macaulay2/Workshop-2016-Warwick
   357baa6..d7d033d  master     -> origin/master
Waiting for Emacs...
Merge made by the 'recursive' strategy.
 RandomIdeals/RandomIdeal.m2 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
einsteinium$ pushd /tmp
/tmp /tmp/demo/Workshop-2016-Warwick-2
einsteinium$ git status
fatal: Not a git repository (or any of the parent directories): .git
einsteinium$ popd
/tmp/demo/Workshop-2016-Warwick-2
einsteinium$ git status
On branch master
Your branch is ahead of 'origin/master' by 3 commits.
  (use "git push" to publish your local commits)
nothing to commit, working directory clean
einsteinium$ git push
Counting objects: 10, done.
Delta compression using up to 8 threads.
Compressing objects:  12% (1/8)   Compressing objects:  25% (2/8)   Compressing objects:  37% (3/8)   Compressing objects:  50% (4/8)   Compressing objects:  62% (5/8)   Compressing objects:  75% (6/8)   Compressing objects:  87% (7/8)   Compressing objects: 100% (8/8)   Compressing objects: 100% (8/8), done.
Writing objects:  10% (1/10)   Writing objects:  20% (2/10)   Writing objects:  30% (3/10)   Writing objects:  40% (4/10)   Writing objects:  50% (5/10)   Writing objects:  60% (6/10)   Writing objects:  70% (7/10)   Writing objects:  80% (8/10)   Writing objects:  90% (9/10)   Writing objects: 100% (10/10)   Writing objects: 100% (10/10), 976 bytes | 0 bytes/s, done.
Total 10 (delta 4), reused 0 (delta 0)
To git@github.com:Macaulay2/Workshop-2016-Warwick.git
   d7d033d..5548845  master -> master
einsteinium$ exit

Process shell finished
