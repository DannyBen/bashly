% download(1) Version 0.1.0 | Sample minimal application without commands
% 
% August 2023

NAME
==================================================

**download** - Sample minimal application without commands

SYNOPSIS
==================================================

**download** SOURCE [TARGET] [OPTIONS]

DESCRIPTION
==================================================

Sample minimal application without commands


ARGUMENTS
==================================================

SOURCE
--------------------------------------------------

URL to download from

- *Required*

TARGET
--------------------------------------------------

Target filename (default: same as source)


OPTIONS
==================================================

--force, -f
--------------------------------------------------

Overwrite existing files


EXAMPLES
==================================================

~~~
download example.com

download example.com ./output -f

~~~


