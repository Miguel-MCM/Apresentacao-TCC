%%
%% This is file `UnBeamer.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% UnBeamer.dtx  (with options: `all,class')
%% 
%% Arquivo gerado automaticamente.
%% 
%% Copyright (C) 2012 by Guilherme N. Ramos (gnramos@unb.br)
%% 
%% Este arquivo pode ser distribuído e/ou modificado conforme:
%%     1. LaTeX Project Public License e/ou
%%     2. GNU Public License.

\NeedsTeXFormat{LaTeX2e}[1999/12/01]%

\ProvidesClass{UnBeamer}[2011/08/01 Classe para apresentações no estilo UnB usando Beamer.]%

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{beamer}}%

%Para gerar notas de aula (4 slides por folha, formato paisagem).
\DeclareOption{notasDeAula}{%
    \def\unbeamer@notasDeAula{1}%
    \PassOptionsToClass{handout}{beamer}%
}%

% Para imprimir linhas ao lado dos slides para anotações.
\DeclareOption{comAnotacoes}{%
    \def\unbeamer@comAnotacoes{1}%
    \PassOptionsToClass{handout}{beamer}%
}%

% Para mostrar slides com o conteúdo (índice) da apresentação (a cada nova seção).
\DeclareOption{mostraConteudo}{\def\unbeamer@mostraConteudo{1}}%

% Criar um poster.
\DeclareOption{poster}{%
    \def\unbeamer@poster{1}%
    \PassOptionsToClass{final}{beamer}%
}%
\def\unbeamer@posterorientation{portrait}
\DeclareOption{orientation=landscape}{\def\unbeamer@posterorientation{landscape}}%

\ProcessOptions\relax%
\LoadClass{beamer}%

\usetheme{UnB}%

%% Carrega o arquivo que gera as notas (divide a folha em 4 slides).
\newcommand{\unbeamer@handoutWithNotes}[2][portrait]{%
    \IfFileExists{handoutWithNotes.sty}{}%
    {% não é possível usar algumas opções.
        \ClassError{UnBeamer}%
        {Arquivo 'handoutWithNotes.sty' não encontrado.}%
        {O arquivo é fornecido no arquivo ZIP do tema UnBeamer, mas pode
        ser encontrado em http://www.guidodiepen.nl/2009/07/creating-latex-beamer-handouts-with-notes/ .}%
    }%
    \RequirePackage{etex}%
    \RequirePackage{handoutWithNotes}%
    \pgfpagesuselayout{#2}[a4paper, #1, border shrink=5mm]%
    \pgfpageslogicalpageoptions{1}{border code=\pgfusepath{stroke}}%
    \pgfpageslogicalpageoptions{2}{border code=\pgfusepath{stroke}}%
    \pgfpageslogicalpageoptions{3}{border code=\pgfusepath{stroke}}%
    \pgfpageslogicalpageoptions{4}{border code=\pgfusepath{stroke}}%
}%

% Definir layout da página conforme as opções.
\ifcsname unbeamer@notasDeAula\endcsname \unbeamer@handoutWithNotes[landscape]{4 on 1} \fi\par%
\ifcsname unbeamer@comAnotacoes\endcsname \unbeamer@handoutWithNotes{4 on 1 with notes} \fi\par%
\ifcsname unbeamer@mostraConteudo\endcsname
    \AtBeginSection[]{%
        \begin{frame}%
            \frametitle{Conte\'{u}do}%
            \tableofcontents[currentsection,hideallsubsections]%
        \end{frame}%
    }%
\fi\par%

\ifcsname unbeamer@poster\endcsname
    \RequirePackage[orientation=\unbeamer@posterorientation,size=a0,scale=1.4]{beamerposter}%
    \RequirePackage{tikz}%
    \RequirePackage{ifthen}%

    \usetikzlibrary{shadows}%
    \pgfdeclarelayer{background}%
    \pgfdeclarelayer{foreground}%
    \pgfsetlayers{background,main,foreground}%

    \newcommand{\contact}[1]{\gdef\unbeamerpresentation@contact{#1}}%
    \newcommand{\insertcontact}{\unbeamerpresentation@contact}%

    \renewcommand{\maketitle}{%
        \begin{columns}[c]%
            \column{.4\textwidth}\centering%
                \huge \insertauthor\\%
                \Large \insertcontact%
            \column{.2\textwidth}\centering%
                \includegraphics[width=.75\textwidth]{UnBMarca.pdf}%
            \column{.4\textwidth}\centering%
                \Large \insertinstitute%
        \end{columns}%
    }%

    \renewcommand{\unbeamerleftfooter}{}%
    \renewcommand{\unbeamerrightfooter}{}%

    \newlength{\unbeamer@titlewidth}%
    \newcommand{\setTitleFontSize}{%
        \VERYHuge%
        \settowidth{\unbeamer@titlewidth}{\inserttitle}%
        \ifthenelse{\lengthtest{\paperwidth>\unbeamer@titlewidth}}{}%
            {\VeryHuge%
            \settowidth{\unbeamer@titlewidth}{\inserttitle}%
            \ifthenelse{\lengthtest{\paperwidth>\unbeamer@titlewidth}}{}%
                {\veryHuge%
                \settowidth{\unbeamer@titlewidth}{\inserttitle}%
                \ifthenelse{\lengthtest{\paperwidth>\unbeamer@titlewidth}}{}%
                    {\Huge%
                    \ifthenelse{\lengthtest{\paperwidth>\unbeamer@titlewidth}}{}%
                        {\huge%
                        \ifthenelse{\lengthtest{\paperwidth>\unbeamer@titlewidth}}{}%
                            {\LARGE%
                            \settowidth{\unbeamer@titlewidth}{\inserttitle}%
                            \ifthenelse{\lengthtest{\paperwidth>\unbeamer@titlewidth}}{}%
                                {\Large%
                                \settowidth{\unbeamer@titlewidth}{\inserttitle}%
                                \ifthenelse{\lengthtest{\paperwidth>\unbeamer@titlewidth}}{}%
                                    {\large}%
                                }%
                            }%
                        }%
                    }%
                }%
            }%
    }%

    \newlength{\unbeamer@headerheight}%
    \setbeamertemplate{headline}{%
        \leavevmode%
        \settoheight{\unbeamer@headerheight}{\setTitleFontSize\inserttitle}%
        \begin{tikzpicture}
            \begin{pgfonlayer}{background}
                \draw[top color=greenUnB,bottom color=blueUnB] (-.1\paperwidth,0) rectangle (0.9\paperwidth, 1.8\unbeamer@headerheight);
            \end{pgfonlayer}
            \begin{pgfonlayer}{foreground}
                \node at (.4\paperwidth, .9\unbeamer@headerheight) {\setTitleFontSize\textcolor{white}{\inserttitle}};
            \end{pgfonlayer}
        \end{tikzpicture}
    }%

    \setbeamerfont{block title}{size=\LARGE}%
 \fi\par%

% Redefinir cores dos blocos (block, alertblock e exampleblock) e possibilitar largura variável.
\newlength{\unbeamer@previousTextWidth}%
\let\unbeamer@oldBlock=\block%
\let\unbeamer@endOldBlock=\endblock%
\renewenvironment{block}[2][\textwidth]{%
    \setlength{\unbeamer@previousTextWidth}{\textwidth}%
    \setlength{\textwidth}{#1}%
    \unbeamer@oldBlock{\ifx#2\@empty\else\textbf{#2}\fi}%
}{%
    \unbeamer@endOldBlock%
    \setlength{\textwidth}{\unbeamer@previousTextWidth}%
}%

\let\unbeamer@oldAlertBlock=\alertblock%
\let\unbeamer@endOldAlertBlock=\endalertblock%
\renewenvironment{alertblock}[2][\textwidth]{%
    \setlength{\unbeamer@previousTextWidth}{\textwidth}%
    \setlength{\textwidth}{#1}%
    \unbeamer@oldAlertBlock{\ifx#2\@empty\else\textbf{#2}\fi}%
}{%
    \unbeamer@endOldAlertBlock%
    \setlength{\textwidth}{\unbeamer@previousTextWidth}%
}%

\let\unbeamer@oldExampleBlock=\exampleblock%
\let\unbeamer@endOldExampleBlock=\endexampleblock%
\renewenvironment{exampleblock}[2][\textwidth]{%
    \setlength{\unbeamer@previousTextWidth}{\textwidth}%
    \setlength{\textwidth}{#1}%
    \unbeamer@oldExampleBlock{\ifx#2\@empty\else\textbf{#2}\fi}%
}{%
    \unbeamer@endOldExampleBlock%
    \setlength{\textwidth}{\unbeamer@previousTextWidth}%
}%

%% Insere um frame com uma imagem ocupando todo o espaço.
\newcommand{\imageFrame}{\begingroup\catcode`_=12\relax\@doimageFrame}%
\newcommand<>{\@doimageFrame}[1]{%
    \only#2{{\usebackgroundtemplate{\includegraphics[height=\paperheight,width=\paperwidth]{#1}}%
    \begin{frame}#2[plain]\frametitle{\@empty}\framesubtitle{\@empty}\end{frame}}}%
    \endgroup%
}% Ex: \imageFrame{UnBMarca}%

%% Insere um frame com uma imagem ocupando todo o espaço horizontal e o centraliza %<class>verticalmente.
\newcommand{\horizImageFrame}{\begingroup\catcode`_=12\relax\@horizImageFrame}%
\newcommand<>{\@horizImageFrame}[1]{%
    \only#2{{\usebackgroundtemplate{%
    \vbox to \paperheight{%
    \vfil%
    \hbox to \paperwidth{\includegraphics[width=\paperwidth]{#1}}
    \vfil}}%
    \begin{frame}#2[plain]\frametitle{\@empty}\framesubtitle{\@empty}\end{frame}}}%
    \endgroup%
}% Ex: \horizImageFrame{UnBMarca}%

%% Insere um frame com uma imagem ocupando todo o espaço vertical e centraliza horizontalmente.
\newcommand{\vertImageFrame}{\begingroup\catcode`_=12\relax\@dovertImageFrame}%
\newcommand<>{\@dovertImageFrame}[1]{%
    \only#2{{\usebackgroundtemplate{%
    \vbox to \paperheight{%
    \hbox to \paperwidth{%
    \hfil\includegraphics[height=\paperheight]{#1}\hfil}}}%
    \begin{frame}#2[plain]\frametitle{\@empty}\framesubtitle{\@empty}\end{frame}}}%
    \endgroup%
}% Ex: \vertImageFrame{UnBMarca}%

%% Risca a palavra
\newlength{\unbeamer@strikeLength}%
\newcommand<>{\strikeText}[1]{%
    \settowidth{\unbeamer@strikeLength}{#1}%
    \mbox{#1}%
    \only#2{\hspace{-\unbeamer@strikeLength}\rule[.5ex]{\unbeamer@strikeLength}{1pt}}%
}% Ex: \strikeText<2->{Lorem ipsum}

%% Cria uma lista (itemize) com um único item.
%%   #1 - símbolo do item (default: -).
%%   #2 - texto do item.
\newcommand<>{\subitem}[2][-]{%
    \only#3{\begin{itemize}%
        \item[#1] #2%
    \end{itemize}}%
}%% Ex: \subitem[$\rightarrow$]{Lorem Ipsum}

\endinput
%%
%% End of file `UnBeamer.cls'.
