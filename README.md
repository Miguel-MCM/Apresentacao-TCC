Apresentação TCC — Aplicativo de acessibilidade com uso de eye-tracking
======================================================================

Slides de apresentação do TCC (Engenharia de Computação — CIC/UnB), feitos
com [Beamer](https://ctan.org/pkg/beamer) e a classe/tema
[UnBeamer](https://github.com/gnramos/UnBeamer).

Estrutura
---------

| Arquivo / pasta      | Conteúdo                                                        |
|----------------------|-----------------------------------------------------------------|
| `apresentacao.tex`   | Documento principal dos slides                                  |
| `referencias.bib`    | Referências bibliográficas (biblatex + biber)                   |
| `figuras/`           | Imagens e diagramas TikZ (`*.tex` compilam para `*.pdf`)        |
| `UnBeamer.dtx`       | Fonte da classe `UnBeamer.cls` e do tema em `theme/`            |
| `UnBMarca.pdf`       | Marca da UnB usada pelo tema                                    |
| `handoutWithNotes.sty` | Pacote auxiliar usado pela classe                             |
| `estrutura.md`       | Roteiro/estrutura planejada da apresentação                     |

Dependências
------------

- Uma distribuição TeX Live com `pdflatex`
- Pacotes LaTeX: `beamer`, `beamerposter`, `pgf`/`tikz`, `standalone`,
  `babel` (português), `lmodern`, `csquotes`, `biblatex`, `etex`, `pgfpages`
- [`biber`](https://ctan.org/pkg/biber) (backend do biblatex)
- `latexmk` (opcional, automatiza as várias passadas)

### Arch Linux / Manjaro

```bash
sudo pacman -S --needed texlive-basic texlive-latex texlive-latexrecommended \
    texlive-latexextra texlive-pictures texlive-fontsrecommended \
    texlive-langportuguese texlive-bibtexextra texlive-binextra biber
```

### Debian / Ubuntu / Mint

```bash
sudo apt install texlive-latex-base texlive-latex-recommended \
    texlive-latex-extra texlive-pictures texlive-fonts-recommended \
    texlive-lang-portuguese texlive-bibtex-extra biber latexmk
```

### Fedora

```bash
sudo dnf install texlive-scheme-medium texlive-beamerposter \
    texlive-babel-portuges texlive-biblatex texlive-csquotes \
    texlive-standalone biber latexmk
```

### Qualquer distribuição (alternativa)

Instale tudo de uma vez com o pacote completo (`texlive-full` no Debian/Ubuntu,
`texlive-scheme-full` no Fedora, ou o grupo `texlive` no Arch), ou use o
[instalador oficial do TeX Live](https://tug.org/texlive/quickinstall.html),
que não precisa de root.

Compilação
----------

### 1. Gerar o tema UnB (apenas uma vez)

Os arquivos do tema (`theme/beamer*themeUnB.sty`) não são versionados e são
gerados a partir do `UnBeamer.dtx`:

```bash
pdflatex UnBeamer.dtx
```

Isso também gera `UnBeamer.cls`, a documentação `UnBeamer.pdf` e os exemplos
`ex_apresentacao.tex` e `ex_poster.tex`.

### 2. Compilar os slides

Os arquivos intermediários (`.aux`, `.log`, `.nav`, `.bcf`, `.bbl`, …) ficam
na pasta `build/`, mantendo a raiz limpa.

Com `latexmk` (o PDF fica na raiz):

```bash
latexmk -pdf -auxdir=build -outdir=. apresentacao.tex
```

Ou manualmente (nesse caso o PDF também vai para `build/`):

```bash
mkdir -p build
pdflatex -output-directory=build apresentacao.tex
biber --input-directory=build --output-directory=build apresentacao
pdflatex -output-directory=build apresentacao.tex
pdflatex -output-directory=build apresentacao.tex
```

O resultado é `apresentacao.pdf` (ou `build/apresentacao.pdf` na compilação
manual).

### 3. (Opcional) Recompilar as figuras TikZ

Os PDFs das figuras já estão no repositório. Para regerá-los após editar um
diagrama:

```bash
cd figuras
for f in fluxo modulos pipeline; do pdflatex "$f.tex"; done
```

### Limpeza

```bash
rm -rf build
```

Problemas comuns
----------------

- **`File 'beamerthemeUnB.sty' not found`** — o tema não foi gerado; rode o
  passo 1.
- **`File 'xxx.sty' not found`** — falta algum pacote LaTeX. Descubra qual
  pacote da distribuição contém o arquivo (`pacman -F xxx.sty`,
  `apt-file search xxx.sty` ou `dnf provides '*/xxx.sty'`) e instale-o.
- **Bibliografia vazia ou citações como `[?]`** — o `biber` não foi executado
  ou não está instalado. A versão do `biber` deve ser compatível com a do
  `biblatex` (instale ambos pelo mesmo gerenciador de pacotes).

Créditos
--------

Classe e tema [UnBeamer](https://github.com/gnramos/UnBeamer), de Guilherme
N. Ramos, distribuídos sob a LPPL e/ou GPL.
