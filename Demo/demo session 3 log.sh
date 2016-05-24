einsteinium$ pwd
/tmp/demo/Workshop-2016-Warwick-2/Demo
einsteinium$ ls
README	demo session 1 log.sh  demo session 2 log.sh
einsteinium$ mkdir foo
einsteinium$ cd foo
einsteinium$ touch a b c e
einsteinium$ ls
a  b  c  e
einsteinium$ cd ..
einsteinium$ ls
README	demo session 1 log.sh  demo session 2 log.sh  foo
einsteinium$ git status
On branch master
Your branch is up-to-date with 'origin/master'.
Untracked files:
  (use "git add <file>..." to include in what will be committed)

	foo/

nothing added to commit but untracked files present (use "git add" to track)
einsteinium$ git add foo
einsteinium$ git status
On branch master
Your branch is up-to-date with 'origin/master'.
Changes to be committed:
  (use "git reset HEAD <file>..." to unstage)

	new file:   foo/a
	new file:   foo/b
	new file:   foo/c
	new file:   foo/e

einsteinium$ 
einsteinium$ git reset HEAD foo/a
einsteinium$ 
einsteinium$ git status
On branch master
Your branch is up-to-date with 'origin/master'.
Changes to be committed:
  (use "git reset HEAD <file>..." to unstage)

	new file:   foo/b
	new file:   foo/c
	new file:   foo/e

Untracked files:
  (use "git add <file>..." to include in what will be committed)

	foo/a

einsteinium$ # now we add .gitignore
einsteinium$ git status
On branch master
Your branch is up-to-date with 'origin/master'.
Changes to be committed:
  (use "git reset HEAD <file>..." to unstage)

	new file:   foo/b
	new file:   foo/c
	new file:   foo/e

Untracked files:
  (use "git add <file>..." to include in what will be committed)

	.gitignore

einsteinium$ git add .gitignore 
einsteinium$ git status
On branch master
Your branch is up-to-date with 'origin/master'.
Changes to be committed:
  (use "git reset HEAD <file>..." to unstage)

	new file:   .gitignore
	new file:   foo/b
	new file:   foo/c
	new file:   foo/e

einsteinium$ git commit -m 'add some files'
[master adbac9d] add some files
 4 files changed, 1 insertion(+)
 create mode 100644 Demo/.gitignore
 create mode 100644 Demo/foo/b
 create mode 100644 Demo/foo/c
 create mode 100644 Demo/foo/e
einsteinium$ git status
On branch master
Your branch is ahead of 'origin/master' by 1 commit.
  (use "git push" to publish your local commits)
Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git checkout -- <file>..." to discard changes in working directory)

	modified:   .gitignore

no changes added to commit (use "git add" and/or "git commit -a")
einsteinium$ git commit -a -m 'update .gitignore'
[master 8733368] update .gitignore
 1 file changed, 1 insertion(+)
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
remote: Total 6 (delta 4), reused 6 (delta 4), pack-reused 0        
Unpacking objects:  16% (1/6)   Unpacking objects:  33% (2/6)   Unpacking objects:  50% (3/6)   Unpacking objects:  66% (4/6)   Unpacking objects:  83% (5/6)   Unpacking objects: 100% (6/6)   Unpacking objects: 100% (6/6), done.
From github.com:Macaulay2/Workshop-2016-Warwick
   bdbf9d1..1da842c  master     -> origin/master
Removing RandomIdeals/demo.m2~
Removing RandomIdeals/#demo.m2#~
Waiting for Emacs...
Merge made by the 'recursive' strategy.
 RandomIdeals/#demo.m2#~ |  0
 RandomIdeals/demo.m2~   | 47 -----------------------------------------------
 2 files changed, 47 deletions(-)
 delete mode 100644 RandomIdeals/#demo.m2#~
 delete mode 100644 RandomIdeals/demo.m2~
einsteinium$ git push
Counting objects: 11, done.
Delta compression using up to 8 threads.
Compressing objects:  11% (1/9)   Compressing objects:  22% (2/9)   Compressing objects:  33% (3/9)   Compressing objects:  44% (4/9)   Compressing objects:  55% (5/9)   Compressing objects:  66% (6/9)   Compressing objects:  77% (7/9)   Compressing objects:  88% (8/9)   Compressing objects: 100% (9/9)   Compressing objects: 100% (9/9), done.
Writing objects:   9% (1/11)   Writing objects:  18% (2/11)   Writing objects:  27% (3/11)   Writing objects:  36% (4/11)   Writing objects:  45% (5/11)   Writing objects:  54% (6/11)   Writing objects:  63% (7/11)   Writing objects:  72% (8/11)   Writing objects:  81% (9/11)   Writing objects:  90% (10/11)   Writing objects: 100% (11/11)   Writing objects: 100% (11/11), 995 bytes | 0 bytes/s, done.
Total 11 (delta 5), reused 0 (delta 0)
To git@github.com:Macaulay2/Workshop-2016-Warwick.git
   1da842c..e93e65a  master -> master
einsteinium$ git status
On branch master
Your branch is up-to-date with 'origin/master'.
nothing to commit, working directory clean
einsteinium$ ls
README	demo session 1 log.sh  demo session 2 log.sh  foo
einsteinium$ cd foo
einsteinium$ ls
a  b  c  e
einsteinium$ git rm b
rm 'Demo/foo/b'
einsteinium$ ls
a  c  e
einsteinium$ git rm --cached c
rm 'Demo/foo/c'
einsteinium$ ls
a  c  e
einsteinium$ git status
On branch master
Your branch is up-to-date with 'origin/master'.
Changes to be committed:
  (use "git reset HEAD <file>..." to unstage)

	deleted:    b
	deleted:    c

Untracked files:
  (use "git add <file>..." to include in what will be committed)

	c

einsteinium$ git commit -m 'remove some files'
[master 6b45280] remove some files
 2 files changed, 0 insertions(+), 0 deletions(-)
 delete mode 100644 Demo/foo/b
 delete mode 100644 Demo/foo/c
einsteinium$ git pull && git push
Already up-to-date.
Counting objects: 4, done.
Delta compression using up to 8 threads.
Compressing objects:  33% (1/3)   Compressing objects:  66% (2/3)   Compressing objects: 100% (3/3)   Compressing objects: 100% (3/3), done.
Writing objects:  25% (1/4)   Writing objects:  50% (2/4)   Writing objects:  75% (3/4)   Writing objects: 100% (4/4)   Writing objects: 100% (4/4), 367 bytes | 0 bytes/s, done.
Total 4 (delta 2), reused 0 (delta 0)
To git@github.com:Macaulay2/Workshop-2016-Warwick.git
   e93e65a..6b45280  master -> master
einsteinium$ pwd
/tmp/demo/Workshop-2016-Warwick-2/Demo/foo
einsteinium$ cd ../../../Workshop-2016-Warwick
einsteinium$ git status
On branch master
Your branch is up-to-date with 'origin/master'.
nothing to commit, working directory clean
einsteinium$ git status
On branch master
Your branch is up-to-date with 'origin/master'.
Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git checkout -- <file>..." to discard changes in working directory)

	modified:   Demo/README

no changes added to commit (use "git add" and/or "git commit -a")
einsteinium$ git commit -a -m 'modify Demo/README'
[master 81f9b76] modify Demo/README
 1 file changed, 2 insertions(+)
einsteinium$ git status
On branch master
Your branch is ahead of 'origin/master' by 1 commit.
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
remote: Counting objects: 537, done.        
remote: Compressing objects:   1% (1/98)           remote: Compressing objects:   2% (2/98)           remote: Compressing objects:   3% (3/98)           remote: Compressing objects:   4% (4/98)           remote: Compressing objects:   5% (5/98)           remote: Compressing objects:   6% (6/98)           remote: Compressing objects:   7% (7/98)           remote: Compressing objects:   8% (8/98)           remote: Compressing objects:   9% (9/98)           remote: Compressing objects:  10% (10/98)           remote: Compressing objects:  11% (11/98)           remote: Compressing objects:  12% (12/98)           remote: Compressing objects:  13% (13/98)           remote: Compressing objects:  14% (14/98)           remote: Compressing objects:  15% (15/98)           remote: Compressing objects:  16% (16/98)           remote: Compressing objects:  17% (17/98)           remote: Compressing objects:  18% (18/98)           remote: Compressing objects:  19% (19/98)           remote: Compressing objects:  20% (20/98)           remote: Compressing objects:  21% (21/98)           remote: Compressing objects:  22% (22/98)           remote: Compressing objects:  23% (23/98)           remote: Compressing objects:  24% (24/98)           remote: Compressing objects:  25% (25/98)           remote: Compressing objects:  26% (26/98)           remote: Compressing objects:  27% (27/98)           remote: Compressing objects:  28% (28/98)           remote: Compressing objects:  29% (29/98)           remote: Compressing objects:  30% (30/98)           remote: Compressing objects:  31% (31/98)           remote: Compressing objects:  32% (32/98)           remote: Compressing objects:  33% (33/98)           remote: Compressing objects:  34% (34/98)           remote: Compressing objects:  35% (35/98)           remote: Compressing objects:  36% (36/98)           remote: Compressing objects:  37% (37/98)           remote: Compressing objects:  38% (38/98)           remote: Compressing objects:  39% (39/98)           remote: Compressing objects:  40% (40/98)           remote: Compressing objects:  41% (41/98)           remote: Compressing objects:  42% (42/98)           remote: Compressing objects:  43% (43/98)           remote: Compressing objects:  44% (44/98)           remote: Compressing objects:  45% (45/98)           remote: Compressing objects:  46% (46/98)           remote: Compressing objects:  47% (47/98)           remote: Compressing objects:  48% (48/98)           remote: Compressing objects:  50% (49/98)           remote: Compressing objects:  51% (50/98)           remote: Compressing objects:  52% (51/98)           remote: Compressing objects:  53% (52/98)           remote: Compressing objects:  54% (53/98)           remote: Compressing objects:  55% (54/98)           remote: Compressing objects:  56% (55/98)           remote: Compressing objects:  57% (56/98)           remote: Compressing objects:  58% (57/98)           remote: Compressing objects:  59% (58/98)           remote: Compressing objects:  60% (59/98)           remote: Compressing objects:  61% (60/98)           remote: Compressing objects:  62% (61/98)           remote: Compressing objects:  63% (62/98)           remote: Compressing objects:  64% (63/98)           remote: Compressing objects:  65% (64/98)           remote: Compressing objects:  66% (65/98)           remote: Compressing objects:  67% (66/98)           remote: Compressing objects:  68% (67/98)           remote: Compressing objects:  69% (68/98)           remote: Compressing objects:  70% (69/98)           remote: Compressing objects:  71% (70/98)           remote: Compressing objects:  72% (71/98)           remote: Compressing objects:  73% (72/98)           remote: Compressing objects:  74% (73/98)           remote: Compressing objects:  75% (74/98)           remote: Compressing objects:  76% (75/98)           remote: Compressing objects:  77% (76/98)           remote: Compressing objects:  78% (77/98)           remote: Compressing objects:  79% (78/98)           remote: Compressing objects:  80% (79/98)           remote: Compressing objects:  81% (80/98)           remote: Compressing objects:  82% (81/98)           remote: Compressing objects:  83% (82/98)           remote: Compressing objects:  84% (83/98)           remote: Compressing objects:  85% (84/98)           remote: Compressing objects:  86% (85/98)           remote: Compressing objects:  87% (86/98)           remote: Compressing objects:  88% (87/98)           remote: Compressing objects:  89% (88/98)           remote: Compressing objects:  90% (89/98)           remote: Compressing objects:  91% (90/98)           remote: Compressing objects:  92% (91/98)           remote: Compressing objects:  93% (92/98)           remote: Compressing objects:  94% (93/98)           remote: Compressing objects:  95% (94/98)           remote: Compressing objects:  96% (95/98)           remote: Compressing objects:  97% (96/98)           remote: Compressing objects:  98% (97/98)           remote: Compressing objects: 100% (98/98)           remote: Compressing objects: 100% (98/98), done.        
Receiving objects:   0% (1/537)   Receiving objects:   1% (6/537)   Receiving objects:   2% (11/537)   Receiving objects:   3% (17/537)   Receiving objects:   4% (22/537)   Receiving objects:   5% (27/537)   Receiving objects:   6% (33/537)   Receiving objects:   7% (38/537)   Receiving objects:   8% (43/537)   Receiving objects:   9% (49/537)   Receiving objects:  10% (54/537)   Receiving objects:  11% (60/537)   Receiving objects:  12% (65/537)   Receiving objects:  13% (70/537)   Receiving objects:  14% (76/537)   Receiving objects:  15% (81/537)   Receiving objects:  16% (86/537)   Receiving objects:  17% (92/537)   Receiving objects:  18% (97/537)   Receiving objects:  19% (103/537)   Receiving objects:  20% (108/537)   Receiving objects:  21% (113/537)   Receiving objects:  22% (119/537)   Receiving objects:  23% (124/537)   Receiving objects:  24% (129/537)   Receiving objects:  25% (135/537)   Receiving objects:  26% (140/537)   Receiving objects:  26% (144/537), 4.64 MiB | 4.56 MiB/s   Receiving objects:  27% (145/537), 4.64 MiB | 4.56 MiB/s   Receiving objects:  28% (151/537), 4.64 MiB | 4.56 MiB/s   Receiving objects:  29% (156/537), 4.64 MiB | 4.56 MiB/s   Receiving objects:  30% (162/537), 4.64 MiB | 4.56 MiB/s   Receiving objects:  31% (167/537), 4.64 MiB | 4.56 MiB/s   Receiving objects:  32% (172/537), 4.64 MiB | 4.56 MiB/s   Receiving objects:  33% (178/537), 4.64 MiB | 4.56 MiB/s   Receiving objects:  34% (183/537), 4.64 MiB | 4.56 MiB/s   Receiving objects:  35% (188/537), 4.64 MiB | 4.56 MiB/s   Receiving objects:  36% (194/537), 4.64 MiB | 4.56 MiB/s   Receiving objects:  37% (199/537), 4.64 MiB | 4.56 MiB/s   Receiving objects:  38% (205/537), 4.64 MiB | 4.56 MiB/s   Receiving objects:  39% (210/537), 4.64 MiB | 4.56 MiB/s   Receiving objects:  40% (215/537), 4.64 MiB | 4.56 MiB/s   Receiving objects:  41% (221/537), 4.64 MiB | 4.56 MiB/s   Receiving objects:  42% (226/537), 4.64 MiB | 4.56 MiB/s   Receiving objects:  43% (231/537), 4.64 MiB | 4.56 MiB/s   Receiving objects:  44% (237/537), 4.64 MiB | 4.56 MiB/s   Receiving objects:  45% (242/537), 4.64 MiB | 4.56 MiB/s   Receiving objects:  46% (248/537), 4.64 MiB | 4.56 MiB/s   Receiving objects:  47% (253/537), 4.64 MiB | 4.56 MiB/s   Receiving objects:  48% (258/537), 4.64 MiB | 4.56 MiB/s   Receiving objects:  49% (264/537), 4.64 MiB | 4.56 MiB/s   Receiving objects:  50% (269/537), 4.64 MiB | 4.56 MiB/s   Receiving objects:  51% (274/537), 4.64 MiB | 4.56 MiB/s   Receiving objects:  52% (280/537), 4.64 MiB | 4.56 MiB/s   Receiving objects:  53% (285/537), 4.64 MiB | 4.56 MiB/s   Receiving objects:  54% (290/537), 4.64 MiB | 4.56 MiB/s   remote: Total 537 (delta 53), reused 2 (delta 2), pack-reused 425        
Receiving objects:  55% (296/537), 4.64 MiB | 4.56 MiB/s   Receiving objects:  56% (301/537), 4.64 MiB | 4.56 MiB/s   Receiving objects:  57% (307/537), 4.64 MiB | 4.56 MiB/s   Receiving objects:  58% (312/537), 4.64 MiB | 4.56 MiB/s   Receiving objects:  59% (317/537), 4.64 MiB | 4.56 MiB/s   Receiving objects:  60% (323/537), 4.64 MiB | 4.56 MiB/s   Receiving objects:  61% (328/537), 4.64 MiB | 4.56 MiB/s   Receiving objects:  62% (333/537), 4.64 MiB | 4.56 MiB/s   Receiving objects:  63% (339/537), 4.64 MiB | 4.56 MiB/s   Receiving objects:  64% (344/537), 4.64 MiB | 4.56 MiB/s   Receiving objects:  65% (350/537), 4.64 MiB | 4.56 MiB/s   Receiving objects:  66% (355/537), 4.64 MiB | 4.56 MiB/s   Receiving objects:  67% (360/537), 4.64 MiB | 4.56 MiB/s   Receiving objects:  68% (366/537), 4.64 MiB | 4.56 MiB/s   Receiving objects:  69% (371/537), 4.64 MiB | 4.56 MiB/s   Receiving objects:  70% (376/537), 8.08 MiB | 5.20 MiB/s   Receiving objects:  71% (382/537), 8.08 MiB | 5.20 MiB/s   Receiving objects:  72% (387/537), 8.08 MiB | 5.20 MiB/s   Receiving objects:  73% (393/537), 8.08 MiB | 5.20 MiB/s   Receiving objects:  74% (398/537), 8.08 MiB | 5.20 MiB/s   Receiving objects:  75% (403/537), 8.08 MiB | 5.20 MiB/s   Receiving objects:  76% (409/537), 8.08 MiB | 5.20 MiB/s   Receiving objects:  77% (414/537), 8.08 MiB | 5.20 MiB/s   Receiving objects:  78% (419/537), 8.08 MiB | 5.20 MiB/s   Receiving objects:  79% (425/537), 8.08 MiB | 5.20 MiB/s   Receiving objects:  80% (430/537), 8.08 MiB | 5.20 MiB/s   Receiving objects:  81% (435/537), 8.08 MiB | 5.20 MiB/s   Receiving objects:  82% (441/537), 8.08 MiB | 5.20 MiB/s   Receiving objects:  83% (446/537), 8.08 MiB | 5.20 MiB/s   Receiving objects:  84% (452/537), 8.08 MiB | 5.20 MiB/s   Receiving objects:  85% (457/537), 8.08 MiB | 5.20 MiB/s   Receiving objects:  86% (462/537), 8.08 MiB | 5.20 MiB/s   Receiving objects:  87% (468/537), 8.08 MiB | 5.20 MiB/s   Receiving objects:  88% (473/537), 8.08 MiB | 5.20 MiB/s   Receiving objects:  89% (478/537), 8.08 MiB | 5.20 MiB/s   Receiving objects:  90% (484/537), 8.08 MiB | 5.20 MiB/s   Receiving objects:  91% (489/537), 8.08 MiB | 5.20 MiB/s   Receiving objects:  92% (495/537), 8.08 MiB | 5.20 MiB/s   Receiving objects:  93% (500/537), 8.08 MiB | 5.20 MiB/s   Receiving objects:  94% (505/537), 8.08 MiB | 5.20 MiB/s   Receiving objects:  95% (511/537), 8.08 MiB | 5.20 MiB/s   Receiving objects:  96% (516/537), 8.08 MiB | 5.20 MiB/s   Receiving objects:  97% (521/537), 8.08 MiB | 5.20 MiB/s   Receiving objects:  98% (527/537), 8.08 MiB | 5.20 MiB/s   Receiving objects:  99% (532/537), 8.08 MiB | 5.20 MiB/s   Receiving objects: 100% (537/537), 8.08 MiB | 5.20 MiB/s   Receiving objects: 100% (537/537), 8.14 MiB | 5.20 MiB/s, done.
Resolving deltas:   0% (0/284)   Resolving deltas:   3% (10/284)   Resolving deltas:   5% (16/284)   Resolving deltas:   7% (21/284)   Resolving deltas:  10% (29/284)   Resolving deltas:  14% (42/284)   Resolving deltas:  16% (48/284)   Resolving deltas:  27% (79/284)   Resolving deltas:  28% (80/284)   Resolving deltas:  30% (87/284)   Resolving deltas:  39% (112/284)   Resolving deltas:  41% (118/284)   Resolving deltas:  50% (142/284)   Resolving deltas:  68% (195/284)   Resolving deltas:  69% (196/284)   Resolving deltas:  71% (202/284)   Resolving deltas:  72% (205/284)   Resolving deltas:  73% (209/284)   Resolving deltas:  75% (215/284)   Resolving deltas:  76% (216/284)   Resolving deltas:  83% (237/284)   Resolving deltas:  84% (241/284)   Resolving deltas:  85% (242/284)   Resolving deltas:  87% (249/284)   Resolving deltas:  88% (251/284)   Resolving deltas:  89% (253/284)   Resolving deltas:  92% (263/284)   Resolving deltas:  93% (266/284)   Resolving deltas:  96% (274/284)   Resolving deltas:  97% (276/284)   Resolving deltas:  98% (279/284)   Resolving deltas:  99% (282/284)   Resolving deltas: 100% (284/284)   Resolving deltas: 100% (284/284), completed with 1 local objects.
From github.com:Macaulay2/Workshop-2016-Warwick
   4a70a65..6b45280  master     -> origin/master
Auto-merging Demo/README
CONFLICT (content): Merge conflict in Demo/README
Automatic merge failed; fix conflicts and then commit the result.
einsteinium$ git status
On branch master
Your branch and 'origin/master' have diverged,
and have 1 and 144 different commits each, respectively.
  (use "git pull" to merge the remote branch into yours)
You have unmerged paths.
  (fix conflicts and run "git commit")

Changes to be committed:

	new file:   Demo/.gitignore
	new file:   Demo/demo session 1 log.sh
	new file:   Demo/demo session 2 log.sh
	new file:   Demo/foo/e
	new file:   Dmodules/Kashiwara.m2
	new file:   Numerical/.circle.m2.swp
	new file:   Numerical/PHCpack.m2
	new file:   Numerical/PHCpack/PHCpackDoc.m2
	new file:   Numerical/PHCpack/examples/_is__Witness__Set__Member.out
	new file:   Numerical/PHCpack/examples/_mixed__Volume.out
	new file:   Numerical/PHCpack/examples/_non__Zero__Filter.out
	new file:   Numerical/PHCpack/examples/_numerical__Irreducible__Decomposition.out
	new file:   Numerical/PHCpack/examples/_refine__Solutions.out
	new file:   Numerical/PHCpack/examples/_solve__Rational__System.out
	new file:   Numerical/PHCpack/examples/_solve__System.out
	new file:   Numerical/PHCpack/examples/_t__Degree.out
	new file:   Numerical/PHCpack/examples/_to__Laurent__Polynomial.out
	new file:   Numerical/PHCpack/examples/_top__Witness__Set.out
	new file:   Numerical/PHCpack/examples/_track__Paths.out
	new file:   Numerical/PHCpack/examples/_zero__Filter.out
	new file:   Numerical/README
	new file:   Numerical/circle.m2
	new file:   Numerical/phc
	new file:   Numerical/sweep_real.m2
	new file:   RandomIdeals/.gitignore
	new file:   RandomIdeals/CMtesting/CMtesting.m2
	modified:   RandomIdeals/RandomIdeal.m2
	modified:   RandomIdeals/ResidualIntersections.m2
	new file:   RandomIdeals/SCMtesting/SCMexamples.m2
	new file:   RandomIdeals/brandens-demo.m2
	new file:   ToricStuff/MLBundles.m2
	new file:   ToricStuff/NormalToricVarieties.m2
	new file:   ToricStuff/NormalToricVarieties/smoothFanoToricVarieties.txt
	new file:   ToricStuff/NormalToricVarieties/smoothFanoToricVarieties5.txt
	new file:   ToricStuff/NormalToricVarieties/smoothFanoToricVarieties6.txt
	new file:   ToricStuff/ToricVectorBundles.m2
	new file:   Tropical/OldFileFromDianesSummerStudent.docx
	new file:   Tropical/PolyhedralObjects.m2
	new file:   Tropical/ProjectBrainstorming
	new file:   Tropical/Tropical.m2
	new file:   Tropical/gfanInterface2.m2
	new file:   Visualize/README.md
	new file:   memoryLeaks/memoryLeak.m2

Unmerged paths:
  (use "git add <file>..." to mark resolution)

	both modified:   Demo/README

einsteinium$ cat Demo/README 
This file is in a directory that Dan made.
<<<<<<< HEAD

Let's add a different line here.
||||||| merged common ancestors
=======

I made a change.

Add a line.

In emacs I used C-x v v to add and commit the file.
>>>>>>> 6b45280f8061751487ef12606c931ac520174258
einsteinium$ # edit it
einsteinium$ cat Demo/README 
This file is in a directory that Dan made.

Let's add a different line here.

I made a change.

Add a line.

In emacs I used C-x v v to add and commit the file.
einsteinium$ git status
On branch master
Your branch and 'origin/master' have diverged,
and have 1 and 144 different commits each, respectively.
  (use "git pull" to merge the remote branch into yours)
You have unmerged paths.
  (fix conflicts and run "git commit")

Changes to be committed:

	new file:   Demo/.gitignore
	new file:   Demo/demo session 1 log.sh
	new file:   Demo/demo session 2 log.sh
	new file:   Demo/foo/e
	new file:   Dmodules/Kashiwara.m2
	new file:   Numerical/.circle.m2.swp
	new file:   Numerical/PHCpack.m2
	new file:   Numerical/PHCpack/PHCpackDoc.m2
	new file:   Numerical/PHCpack/examples/_is__Witness__Set__Member.out
	new file:   Numerical/PHCpack/examples/_mixed__Volume.out
	new file:   Numerical/PHCpack/examples/_non__Zero__Filter.out
	new file:   Numerical/PHCpack/examples/_numerical__Irreducible__Decomposition.out
	new file:   Numerical/PHCpack/examples/_refine__Solutions.out
	new file:   Numerical/PHCpack/examples/_solve__Rational__System.out
	new file:   Numerical/PHCpack/examples/_solve__System.out
	new file:   Numerical/PHCpack/examples/_t__Degree.out
	new file:   Numerical/PHCpack/examples/_to__Laurent__Polynomial.out
	new file:   Numerical/PHCpack/examples/_top__Witness__Set.out
	new file:   Numerical/PHCpack/examples/_track__Paths.out
	new file:   Numerical/PHCpack/examples/_zero__Filter.out
	new file:   Numerical/README
	new file:   Numerical/circle.m2
	new file:   Numerical/phc
	new file:   Numerical/sweep_real.m2
	new file:   RandomIdeals/.gitignore
	new file:   RandomIdeals/CMtesting/CMtesting.m2
	modified:   RandomIdeals/RandomIdeal.m2
	modified:   RandomIdeals/ResidualIntersections.m2
	new file:   RandomIdeals/SCMtesting/SCMexamples.m2
	new file:   RandomIdeals/brandens-demo.m2
	new file:   ToricStuff/MLBundles.m2
	new file:   ToricStuff/NormalToricVarieties.m2
	new file:   ToricStuff/NormalToricVarieties/smoothFanoToricVarieties.txt
	new file:   ToricStuff/NormalToricVarieties/smoothFanoToricVarieties5.txt
	new file:   ToricStuff/NormalToricVarieties/smoothFanoToricVarieties6.txt
	new file:   ToricStuff/ToricVectorBundles.m2
	new file:   Tropical/OldFileFromDianesSummerStudent.docx
	new file:   Tropical/PolyhedralObjects.m2
	new file:   Tropical/ProjectBrainstorming
	new file:   Tropical/Tropical.m2
	new file:   Tropical/gfanInterface2.m2
	new file:   Visualize/README.md
	new file:   memoryLeaks/memoryLeak.m2

Unmerged paths:
  (use "git add <file>..." to mark resolution)

	both modified:   Demo/README

einsteinium$ git add Demo/README 
einsteinium$ git status
On branch master
Your branch and 'origin/master' have diverged,
and have 1 and 144 different commits each, respectively.
  (use "git pull" to merge the remote branch into yours)
All conflicts fixed but you are still merging.
  (use "git commit" to conclude merge)

Changes to be committed:

	new file:   Demo/.gitignore
	modified:   Demo/README
	new file:   Demo/demo session 1 log.sh
	new file:   Demo/demo session 2 log.sh
	new file:   Demo/foo/e
	new file:   Dmodules/Kashiwara.m2
	new file:   Numerical/.circle.m2.swp
	new file:   Numerical/PHCpack.m2
	new file:   Numerical/PHCpack/PHCpackDoc.m2
	new file:   Numerical/PHCpack/examples/_is__Witness__Set__Member.out
	new file:   Numerical/PHCpack/examples/_mixed__Volume.out
	new file:   Numerical/PHCpack/examples/_non__Zero__Filter.out
	new file:   Numerical/PHCpack/examples/_numerical__Irreducible__Decomposition.out
	new file:   Numerical/PHCpack/examples/_refine__Solutions.out
	new file:   Numerical/PHCpack/examples/_solve__Rational__System.out
	new file:   Numerical/PHCpack/examples/_solve__System.out
	new file:   Numerical/PHCpack/examples/_t__Degree.out
	new file:   Numerical/PHCpack/examples/_to__Laurent__Polynomial.out
	new file:   Numerical/PHCpack/examples/_top__Witness__Set.out
	new file:   Numerical/PHCpack/examples/_track__Paths.out
	new file:   Numerical/PHCpack/examples/_zero__Filter.out
	new file:   Numerical/README
	new file:   Numerical/circle.m2
	new file:   Numerical/phc
	new file:   Numerical/sweep_real.m2
	new file:   RandomIdeals/.gitignore
	new file:   RandomIdeals/CMtesting/CMtesting.m2
	modified:   RandomIdeals/RandomIdeal.m2
	modified:   RandomIdeals/ResidualIntersections.m2
	new file:   RandomIdeals/SCMtesting/SCMexamples.m2
	new file:   RandomIdeals/brandens-demo.m2
	new file:   ToricStuff/MLBundles.m2
	new file:   ToricStuff/NormalToricVarieties.m2
	new file:   ToricStuff/NormalToricVarieties/smoothFanoToricVarieties.txt
	new file:   ToricStuff/NormalToricVarieties/smoothFanoToricVarieties5.txt
	new file:   ToricStuff/NormalToricVarieties/smoothFanoToricVarieties6.txt
	new file:   ToricStuff/ToricVectorBundles.m2
	new file:   Tropical/OldFileFromDianesSummerStudent.docx
	new file:   Tropical/PolyhedralObjects.m2
	new file:   Tropical/ProjectBrainstorming
	new file:   Tropical/Tropical.m2
	new file:   Tropical/gfanInterface2.m2
	new file:   Visualize/README.md
	new file:   memoryLeaks/memoryLeak.m2

einsteinium$ git commit
Waiting for Emacs...
[master 1fd0e85] Merge branch 'master' of github.com:Macaulay2/Workshop-2016-Warwick
einsteinium$ git log -1
commit 1fd0e85c161b5365eec877b6440f2ddba9d4121a
Merge: 81f9b76 6b45280
Author: Daniel R. Grayson <dan@math.uiuc.edu>
Date:   Tue May 24 09:25:41 2016 +0100

    Merge branch 'master' of github.com:Macaulay2/Workshop-2016-Warwick
    
    I had a painful conflict. uggh.
einsteinium$ git pull && git push
Already up-to-date.
Counting objects: 8, done.
Delta compression using up to 8 threads.
Compressing objects:  14% (1/7)   Compressing objects:  28% (2/7)   Compressing objects:  42% (3/7)   Compressing objects:  57% (4/7)   Compressing objects:  71% (5/7)   Compressing objects:  85% (6/7)   Compressing objects: 100% (7/7)   Compressing objects: 100% (7/7), done.
Writing objects:  12% (1/8)   Writing objects:  25% (2/8)   Writing objects:  37% (3/8)   Writing objects:  50% (4/8)   Writing objects:  62% (5/8)   Writing objects:  75% (6/8)   Writing objects:  87% (7/8)   Writing objects: 100% (8/8)   Writing objects: 100% (8/8), 790 bytes | 0 bytes/s, done.
Total 8 (delta 5), reused 0 (delta 0)
To git@github.com:Macaulay2/Workshop-2016-Warwick.git
   6b45280..1fd0e85  master -> master
einsteinium$ git config --global merge.conflictstyle diff3
einsteinium$ cat ~/.gitconfig 
[user]
	name = Daniel R. Grayson
	email = dan@math.uiuc.edu
[push]
	default = matching
[filter "media"]
	required = true
	clean = git media clean %f
	smudge = git media smudge %f
[merge]
	conflictstyle = diff3
[filter "lfs"]
	required = true
	clean = git-lfs clean %f
	smudge = git-lfs smudge %f
einsteinium$ printenv EDITOR
emacsclient
einsteinium$ git config --global core.editor emacs
einsteinium$ cat ~/.gitconfig 
[user]
	name = Daniel R. Grayson
	email = dan@math.uiuc.edu
[push]
	default = matching
[filter "media"]
	required = true
	clean = git media clean %f
	smudge = git media smudge %f
[merge]
	conflictstyle = diff3
[filter "lfs"]
	required = true
	clean = git-lfs clean %f
	smudge = git-lfs smudge %f
[core]
	editor = emacs
einsteinium$ grep EDITOR ~/.emacs
(server-start) (setenv "EDITOR" "emacsclient")
einsteinium$ 