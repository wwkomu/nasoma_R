
# Nuggets

A compilation of the side notes, asides, jokes, the smart-ass moments, all the pieces of nuggets that an ordinary student miss gaining a natural feel for R programming.

source: [Riffomonas Project](https://riffomonas.org/) by Dr. P. Scholls

## CC017: Automating README instructions with bash scripts
Taking the autobaurn, albeit in a horse back! :monkey:


:star: Nuggets -- is there an emoji rep for nuggets? I mean, nuggets of wisdom, duh!

:key: `shebang` #Best practice, always start with shebang

#### shebaang!
    #!/usr/bin/env bash #atom

#### Make it execu..able
    chmod +x hello.sh #bash mine .zsh

:sos: Issue, I modified my bash! TODAY! Thus, my format should be .zsh not .sh

####


## Asides

`ls -[]()`

`-[]()`

While i was entering the profs `ls` and `ls -l` and `ls -lth` (sort by time and print human-friendly) I discovered `-l` in this env gmd instert the

`-[]()`

Lesson: Learn more by doing, not just riffing!!!!!!




Sideshows: My silly notes

:sos:
**A peek into...not pick**

THE GIST IS TO GET THE SCRIPT DOWNLOAD LIKE WE DID IN COMMAND LINE

But creating multiple scripts is kinda redundant. Check the codes for fasta and tsv. There is a pattern. Only the name is changing!

# get_rrnDB_fasta.zsh
wget -nc -P data/raw/ https://rrndb.umms.med.umich.edu/static/download/rrnDB-5.8_16S_rRNA.fasta.zip
unzip -n -d data/raw/ data/raw/rrnDB-5.8_16S_rRNA.fasta.zip

# get_rrnDB_tsv.zsh
wget -nc -P data/raw/ https://rrndb.umms.med.umich.edu/static/download/rrnDB-5.8.tsv.zip
unzip -n -d data/raw/ data/raw/rrnDB-5.8.tsv.zip


DRY
The code that is efficient in that it does not repeat itself:

```
wget -nc -P data/raw/ https://rrndb.umms.med.umich.edu/static/download/"$archive".zip
unzip -n -d data/raw/ data/raw/"$archive".zip

```
## Note:

1. You dont need the quotes
2. However, it is safer...to avoid bombs when you have spaces in your files names
3. You can't use '' so, make it a habit of using ""!
    What does not kill... Oh. No.
    Let's kill the shenanigans
4. With the above code, we only have to pass the names and the other stuff is catered for!

The final code is like:

:: First lesson to drying your code - that's, make ur code less repetitive:
      :SOS: A big area for me to consider being extremely attentive because I have thousands of scripts all over my computer and it has been a few days!

  :key: Know your weakness and focus on it!

  **Cliche,** huh?

```
#!/usr/bin/env bash

archive=$1

wget -nc -P data/raw/ https://rrndb.umms.med.umich.edu/static/download/"$archive".zip
unzip -n -d data/raw/ data/raw/"$archive".zip
```

# Episodes #CC019

Created a Makefile that automate the processes we created the bash scripts for in CC018

# :sparkles: Goldies
- Remove multiple files with:

  `rm mothur.*.logfiles `

  This removes all mothur logfiles ragardless of log number `*` is the wildcard for all..

- Test make without running it with:

  `make -n`

  This returns the file name... if nothing to is the result, there is an error. Main errors are spelling one!!


# Episodes C020
## sed
Making our automation smarter!!! No hard-coded paths!

NB: issue_12 while PS is on issue_11

## general syntax of sed

It is like find and replace

 `echo $variable | sed s/find/replace`

 `//` replace with nothing!

# Limitations

Very specific

solution is to use *meta chars* `.` and `*`

`* `is greedy so it will go to the last `/` and return

`echo $target | sed "s/.*\///"` extract file name

How do we get the paths

`echo $target | sed -E "s/(.*\/).*/\1/"`

`parethesis`  wraps what we want that matches the wrap

`-E `elegant otherwise, one will have to use `\` like:

`echo $target | sed -E "s/\(.*\/\).*/\1/"`

## Demo

- create a target

`target = data/raw/rrnDB-5.8_16S_rRNA.fasta`
