# Testing Unreleased (Edge) Bashly Versions

If you wish to try a version of bashly straight from GitHub before it is
released, you can use one of these methods:

## Using Docker

```bash
alias bashly_edge='docker run --rm -it --user $(id -u):$(id -g) --volume "$PWD:/app" dannyben/bashly:edge'
```

or build your own image with [this Dockerfile](Dockerfile).

## Using Ruby

```bash
git clone --depth 1 https://github.com/DannyBen/bashly.git
cd bashly
gem build bashly.gemspec
gem install bashly*.gem
cd ..
```
