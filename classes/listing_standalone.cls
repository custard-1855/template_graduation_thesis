\ProvidesClass{classes/listing_standalone}[2025/12/24 Lightweight Listings Standalone]

% ベースクラス
\LoadClass[a4paper,11pt]{article}

% 日本語対応
\RequirePackage{luatexja}        % LuaLaTeX日本語対応
\RequirePackage{luatexja-fontspec} % フォント設定

% フォントプリセット（INIAD_modernと統一）
\RequirePackage[haranoaji,no-math,deluxe]{luatexja-preset}

% 見出しフォント設定用パッケージ
\RequirePackage{titlesec}

% section, subsection, subsubsectionを12pt明朝体に設定（INIAD_modernと統一）
\titleformat{\section}
  {\normalfont\fontsize{12}{14.4}\selectfont}{\thesection}{1em}{}
\titleformat{\subsection}
  {\normalfont\fontsize{12}{14.4}\selectfont}{\thesubsection}{1em}{}
\titleformat{\subsubsection}
  {\normalfont\fontsize{12}{14.4}\selectfont}{\thesubsubsection}{1em}{}

% 見出しの前後スペース調整（INIAD_modernと統一）
\titlespacing*{\section}{0pt}{30pt}{30pt}
\titlespacing*{\subsection}{0pt}{20pt}{20pt}
\titlespacing*{\subsubsection}{0pt}{15pt}{15pt}

% 必要最小限のパッケージ
\RequirePackage{subfiles}       % subfileサポート
\RequirePackage{xcolor}          % 色設定
\RequirePackage{minted}          % ソースコード表示（Pygments使用）

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
