# cli download

Download a file

| Attributes       | &nbsp;
|------------------|-------------
| Alias:           | d

## Usage

```bash
cli download SOURCE [TARGET] [OPTIONS]
```

## Examples

```bash
cli download example.com
```

```bash
cli download example.com ./output -f
```

## Environment Variables

#### *DEFAULT_TARGET_LOCATION*

Set the default location to download to

## Arguments

#### *SOURCE*

URL to download from

| Attributes      | &nbsp;
|-----------------|-------------
| Required:       | ✓ Yes

#### *TARGET*

Target filename (default: same as source)

## Options

#### *--force, -f*

Overwrite existing files


