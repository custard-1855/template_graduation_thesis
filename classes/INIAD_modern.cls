\ProvidesClass{classes/INIAD_modern}[2025/11/30 INIAD Thesis Modern Template]

% --- 1. ベースクラスの設定 (report.cls準拠) ---
\RequirePackage{plautopatch}
\NeedsTeXFormat{LaTeX2e}

% A4, 11pt, reportモード (jlreq)
\LoadClass[
    paper=a4,
    fontsize=11pt,
    disablejfam,
    head_space=30mm,
    foot_space=30mm,
    gutter=25mm,
    fore-edge=25mm,
    linegap=1zw,
    report
]{jlreq}

% --- 2. 必須パッケージ読み込み (report.cls + 互換性) ---
\RequirePackage{ifptex}
\RequirePackage{ifluatex}
\RequirePackage{setspace}
\RequirePackage{here}
\RequirePackage{bm}
\RequirePackage[hyphens]{xurl}
\urlstyle{same}
\RequirePackage{paralist}
\RequirePackage{amssymb, amsmath, mathtools, amsthm}
\RequirePackage{newtxtext,newtxmath} % 欧文はTimes系 (論文標準)
\RequirePackage{tabularray}
\RequirePackage{siunitx}
\RequirePackage{subfiles}
\RequirePackage{indentfirst}
\RequirePackage{type1cm}
\RequirePackage{graphicx}
\RequirePackage{booktabs} % きれいな表のため追加推奨
\RequirePackage{listings} % ソースコード表示
\RequirePackage{jvlisting} % 日本語対応ソースコード表示

% listingsの設定
\lstset{
  basicstyle={\ttfamily},
  identifierstyle={\small},
  commentstyle={\small\itshape},
  keywordstyle={\small\bfseries},
  ndkeywordstyle={\small},
  stringstyle={\small\ttfamily},
  frame={tb},
  breaklines=true,
  columns=[l]{fullflexible},
  numbers=left,
  xrightmargin=0pt,
  xleftmargin=3em,
  numberstyle={\scriptsize},
  stepnumber=1,
  numbersep=1em,
  lineskip=-0.5ex
}

% minted（Pygments使用のソースコード表示）
\RequirePackage{xcolor}
\RequirePackage{minted}

% mintedの基本設定
\setminted{
  fontsize=\small,
  breaklines=true,
  linenos=true,
  numbersep=8pt,
  frame=lines,
  framesep=2mm,
  autogobble=true,
  python3=true
}

% LuaLaTeX設定
\ifluatex
    \RequirePackage{luatexja}
    \RequirePackage{luatexja-fontspec}

    % 原ノ味フォントプリセットを使用（明朝・ゴシック）
    \RequirePackage[haranoaji,no-math,deluxe]{luatexja-preset}

    % 見出しはゴシック体
    \newcommand{\headfont}{\gtfamily}

    \RequirePackage[unicode,hidelinks,pdfusetitle]{hyperref}
\else
    \ClassError{INIAD_modern}{This class is for LuaLaTeX only.}{Please use lualatex compiler.}
\fi

% --- 3. INIAD独自の変数定義 (INIAD.clsより移植) ---
% 学部・大学院の切り替えオプション（今回はシンプルにデフォルト設定または分岐）
\newif\if@english \@englishfalse
\DeclareOption{english}{\@englishtrue}
\ProcessOptions\relax

% 変数定義
\newcommand*{\studentid}[1]{\gdef\@studentid{#1}}
\newcommand*{\supervisor}[1]{\gdef\@supervisor{#1}}
\newcommand*{\keywords}[1]{\gdef\@keywords{#1}}

% デフォルト値（所属など）
% \gdef\@belongsto{東洋大学情報連携学部情報連携学科} % 必要に応じて分岐ロジックを追加可能

% --- 4. 表紙 (Title Page) の再定義 (INIAD.clsのデザインを再現) ---
\renewcommand{\maketitle}{%
  \begin{titlepage}%
    \let\footnote\relax
    \null\vskip115\p@
    % タイトルは20pt、細字
    \begin{center}\ltseries\fontsize{20}{24}\selectfont%
      \parbox{\linewidth}{\centering \@title}%
    \end{center}
    \null\vskip115\p@
    \begin{center}
      \fontsize{11}{13.2}\selectfont
      \begin{tabular}[t]{rl}%
        学籍番号： & \@studentid \\[5\p@]
        氏名： & \@author \\[5\p@]
        指導教員名： & \@supervisor
      \end{tabular}\par
      \vskip 2cm
      {\@date\par}%
    %   \vskip 2cm
    %   {\@belongsto \par}%
    \end{center}\par
    \vskip60\p@\null
  \end{titlepage}%
  \setcounter{footnote}{0}%
  \global\let\maketitle\relax
  \global\let\@author\@empty
  \global\let\@date\@empty
  \global\let\@title\@empty
}

% --- 5. 概要 (Abstract) 環境の定義 ---
\renewcommand{\abstractname}{論文要旨}
\renewenvironment{abstract}{%
  \cleardoublepage
  \null
  \begin{center}%
    % 要旨タイトルは12pt、細字
    {\ltseries\fontsize{12}{14.4}\selectfont \abstractname}
  \end{center}\par
  \vskip\baselineskip
}{\par\vfill\null}

% 英語要旨環境（オプション）
\newcommand{\eabstractname}{Abstract}
\newcommand*{\etitle}[1]{\gdef\@etitle{#1}}
\newenvironment{eabstract}{%
  \cleardoublepage
  \null
  \begin{center}%
    {\ltseries\fontsize{20}{24}\selectfont \@etitle}
  \end{center}
  \vskip2\baselineskip
  \begin{center}%
    {\ltseries\fontsize{12}{14.4}\selectfont \eabstractname}
  \end{center}\par
  \vskip\baselineskip
}{\par\vfill\null}

% 目次タイトルのカスタマイズ（細字に）
\renewcommand{\tableofcontents}{%
  \chapter*{\ltseries\contentsname}%
  \@starttoc{toc}%
}

% --- 6. ユーティリティ定義 (report.clsより継承) ---
\RequirePackage{caption}
\RequirePackage{subcaption}
\captionsetup[figure]{labelsep=quad, labelformat=simple, name=図}
\captionsetup[subfigure]{labelsep=quad, labelformat=simple, name=図}
\renewcommand*{\thesubfigure}{(\alph{subfigure})}
\captionsetup[table]{labelsep=quad, labelformat=simple, name=表}

% 参照マクロ
\newcommand{\FigTableEq}[3][]{%
    \def\temp{#1}%
    \ifx\temp\empty{#2~\ref{#3}}\else\textbf{#2~\ref{#3}}\fi
}
\newcommand{\Fig}[2][]{\FigTableEq[#1]{Fig.}{#2}}
\newcommand{\Figure}[2][]{\FigTableEq[#1]{Figure}{#2}}
\newcommand{\Table}[2][]{\FigTableEq[#1]{Table}{#2}}
\newcommand{\Eq}[2][]{\FigTableEq[#1]{Eq.}{#2}}

% BibLaTeX設定
\RequirePackage[bibstyle=bibliography,sorting=none,date=year,isbn=false,doi,giveninits,urldate=iso,seconds]{biblatex}
\addbibresource{references.bib}

% --- 7. 見出しのフォント・サイズ設定 (見出し: 12pt ゴシック) ---
% chapterは「1.」形式、12pt明朝
\RenewBlockHeading{chapter}{0}{%
    lines=6,
    label_format={\thechapter.},
    font={\fontsize{12}{14.4}\selectfont}
}

% section, subsection, subsubsectionも12pt明朝
\RenewBlockHeading{section}{1}{%
    font={\fontsize{12}{14.4}\selectfont}
}

\RenewBlockHeading{subsection}{2}{%
    font={\fontsize{12}{14.4}\selectfont}
}

\RenewBlockHeading{subsubsection}{3}{%
    font={\fontsize{12}{14.4}\selectfont}
}

% 見出しの前後スペース調整
\ModifyHeading{section}{before_space=30pt, after_space=30pt}
\ModifyHeading{subsection}{before_space=20pt, after_space=20pt}
\ModifyHeading{subsubsection}{before_space=15pt, after_space=15pt}

% 見出しが連続する際の行取り設定
\SetBlockHeadingSpaces{
    {_chapter{*},_section{before_space=0pt, after_space=15pt}},
    {_section{*},_subsection{before_space=5pt, after_space=15pt}},
    {_subsection{*},_subsubsection{before_space=5pt, after_space=15pt}}
}

% --- 8. 論文構成用コマンド (INIAD.clsより継承) ---
% jlreqのreportモードには\frontmatterなどがないため新規定義
\newif\if@mainmatter
\@mainmattertrue

\newcommand\frontmatter{%
  \@mainmatterfalse
  \pagenumbering{roman}
}

\newcommand\mainmatter{%
  \cleardoublepage
  \@mainmattertrue
  \pagenumbering{arabic}
}

\newcommand\backmatter{%
  \clearpage
  \@mainmatterfalse
}

\renewcommand{\appendix}{\par
  \@mainmattertrue%
  \setcounter{chapter}{0}%
  \setcounter{section}{0}%
  \gdef\@chapapp{\appendixname}%
  \gdef\@chappos{}%
  \gdef\thechapter{\@Alph\c@chapter}
}

% --- 9. 目次深度とセクション番号深度の設定 ---
\setcounter{tocdepth}{2}
\setcounter{secnumdepth}{4}