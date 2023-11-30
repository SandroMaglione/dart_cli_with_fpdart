# `CLI using fpdart Functional Programming`
<p>
  <a href="https://github.com/SandroMaglione">
    <img alt="GitHub: SandroMaglione" src="https://img.shields.io/github/followers/SandroMaglione?label=Follow&style=social" target="_blank" />
  </a>
  <a href="https://twitter.com/SandroMaglione">
    <img alt="Twitter: SandroMaglione" src="https://img.shields.io/twitter/follow/SandroMaglione.svg?style=social" target="_blank" />
  </a>
</p>

Learn how to use [`fpdart`](https://github.com/SandroMaglione/fpdart) to build a CLI application in dart.

> This project implements a dart CLI application using `fpdart` that scans a dart project to find unused files.

***

This project is part of my weekly newsletter at [**sandromaglione.com**](https://www.sandromaglione.com/newsletter?ref=Github&utm_medium=newsletter_project&utm_term=dart&utm_term=fpdart).


<a href="https://www.sandromaglione.com/newsletter?ref=Github&utm_medium=newsletter_project&utm_term=dart&utm_term=fpdart">
    <img alt="sandromaglione.com Newsletter weekly project" src="https://www.sandromaglione.com/static/images/newsletter_banner.webp" target="_blank" /> 
</a>

## Project structure
The implementation is contained inside the [`lib`](./lib/) folder. The entry point is the [`main.dart`](./lib/main.dart) file.

The CLI executes the [`dart_cli_with_fpdart.dart`](./bin/dart_cli_with_fpdart.dart) file.

This file imports the `program` function from `main.dart`.

The app has the following package dependencies ([`pubspec.yaml`](./pubspec.yaml)):

```yaml
dependencies:
  fpdart: ^1.1.0
  args: ^2.4.2
  equatable: ^2.0.5
  yaml: ^3.1.2
```

> **Note**: `cli_options.yaml` is a file specific for this project, it is not a standard dart configuration file. Read more in the article below

**Read all the details in the full article** 👇

<a href="https://www.sandromaglione.com/articles/how-to-implement-a-dart-cli-using-fpdart?ref=Github&utm_medium=newsletter_project&utm_term=fpdart">
    <img alt="Read the full article on my website" src="https://www.sandromaglione.com/api/image?title=How%20to%20implement%20a%20Dart%20CLI%20using%20fpdart&publishedAt=2023-11-29" target="_blank" /> 
</a>