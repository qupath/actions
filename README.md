# GitHub actions for QuPath

This repo contains reusable actions for QuPath-related projects.


## Usage

The basic gradle CI can be used as follows:

```yaml
jobs:
  build:
    steps:
      - uses: qupath/actions/.github/workflows/gradle.yml@main
```

For more complex builds, you can change the input variables, e.g.

```yaml
jobs:
  build:
    steps:
      - uses: qupath/actions/.github/workflows/gradle.yml@main
        with:
          java-version: 17
          java-distribution: liberica
          artifact-name: my-silly-artifact-name
          gradle-args: shadowJar
```

Similarly, SciJava maven snapshots and releases can be made, respectively, using

```yaml
jobs:
  build:
    steps:
      - uses: qupath/actions/.github/workflows/scijava-maven.yml@main
```

and

```yaml
jobs:
  build:
    steps:
      - uses: qupath/actions/.github/workflows/scijava-maven.yml@main
        with: 
          release: true
```

Similar build arguments can be passed in here, although gradle arguments are "extra arguments" and don't replace the single `publish` command.


Github draft releases can be made with:

```yaml
jobs:
  build:
    steps:
      - uses: qupath/actions/.github/workflows/github-release.yml@main
```

## Versioning

Currently it's probably best if we use main by default.
Once stable, we should consider tagging this repository to improve reproducibility and traceability.

## Updating repositories

Currently, repos will need to be updated manually.
Although this repo will reduce duplication a bit, it may still be a bit painful as our repositories grow in number.
Therefore we should consider adding actions here that can update gradle and action versions across our repositories.
