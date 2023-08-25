# cli download

Download a file

| Attributes       | &nbsp;
|------------------|-------------
| Alias:           | d

## Usage

```bash
cli download SOURCE [TARGET] [OPTIONS] [AWS PARAMS...]
```

## Examples

```bash
cli download example.com
```
```bash
cli download example.com ./output -f
```

## Arguments

#### *SOURCE*

URL to download from

| Attributes      | &nbsp;
|-----------------|-------------
| Required:       | ✓ Yes

#### *TARGET*

Target filename (default: same as source)

#### *AWS PARAMS...*

Additional arguments or flags for AWS CLI

## Options

#### *--force, -f*

Overwrite existing files

