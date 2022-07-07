\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{question}

\input{pyp_base.cls}

%%%%% New Features %%%%%

\newcommand{\subject}[1]{%
    \setcounter{section}{0}
    \par
    \noindent\makebox[\linewidth]{\color{black!70}{\rule{\linewidth}{0.4pt}}}
    \vspace{-1.3em}
    
    \noindent{\Large \textbf{\hfill #1\hfill}}
    
    \vspace{-0.7em}
    \noindent\makebox[\linewidth]{\color{black!70}{\rule{\linewidth}{0.4pt}}}
    \par
}

\newcommand{\helloworld}[5]{%
    \hrule
    \vspace{10pt}
    \begin{minipage}[t]{0.2\linewidth}
        \vspace*{\fill}
        \begin{center}
            \Huge \nfont #1 \\[6pt]
            \large 學年度
        \end{center}
        \vspace*{\fill}
    \end{minipage}
    \hfill
    \begin{minipage}[t]{0.65\linewidth}
        \Large
        \vspace*{\fill}
        #2~#3甄選入學\\[9pt]
        #4能力檢定~試題本
        \vspace*{\fill}
    \end{minipage}
    \hrule 
    \vspace{10pt}
    \hspace{20pt}
    測驗時間：#5分鐘
    \hfill
    \textbf{\large 翻印必究}
    \hfill
    試卷：共\pageref{LastPage} 頁\hspace{40pt}
    \vspace{20pt}
}

\newcounter{partnum}

\newcounter{choice}
\ifthenelse{\boolean{@isScience}}{
        \renewcommand\thechoice{(\Alph{choice})}
    }{
        \renewcommand\thechoice{(\arabic{choice})}
    }
\newcommand\choicelabel{\thechoice}

\newenvironment{choices}{
    \list{\choicelabel}{%
        \usecounter{choice}\def\makelabel##1{\hss\llap{##1}}%
        \settowidth{\leftmargin}{W.\hskip\labelsep\hskip 0.2em}%
        \def\choice{%
            \item
        } % choice
        \def\task{
            \item
        }
        \labelwidth\leftmargin\advance\labelwidth-\labelsep
        \topsep=5pt
        \partopsep=0pt
        \itemsep=0em
    }%
}{\endlist}

\newenvironment{oneparchoices}{%
    \setcounter{choice}{0}%
    \def\choice{%
        \refstepcounter{choice}%
        \ifnum\value{choice}>1\relax
            \penalty -50\hskip 1em plus 1em\relax
        \fi
        \choicelabel
        \nobreak\enskip
    }
    % choice
    % If we're continuing the paragraph containing the question,
    % then leave a bit of space before the first choice:
    \ifvmode\else\enskip\fi
    \ignorespaces
}{}

\newcounter{number}
\setcounter{number}{0}
\newcounter{quesnum}
\setcounter{quesnum}{0}

\newenvironment{questions}{%
    \setcounter{quesnum}{0}
    \begin{enumerate}[%
        label=\arabic*.\ ,
        leftmargin=35pt,
        itemsep=1em
    ]
}{
    \setcounter{number}{\value{enumi}}%
    \end{enumerate}
}

\newenvironment{cquestions}{%
    \begin{enumerate}[label=\arabic*.\ , leftmargin=35pt]%
    \setcounter{enumi}{\value{number}}
}{%
    \end{enumerate}
    \setcounter{enumi}{0}
}

\newcommand{\question}[1][]{%
    \ifthenelse{%
        \isempty{#1}
    }{%
        \stepcounter{quesnum}
        \item[\thequesnum.]
    }{%
        \stepcounter{quesnum}
        \item[{\Large \textcircled{\small\sffamily #1}}~\thequesnum.]
    }
}

\newenvironment{parts}{%
    \begin{enumerate}[label=(\arabic*),leftmargin=35pt]
    \setcounter{partnum}{0}
}{%
    \end{enumerate}
}

\renewcommand{\part}[1][]{%
    \ifthenelse{%
        \isempty{#1}
    }{%
        \stepcounter{partnum}
        \item[(\thepartnum)]
    }{%
        \stepcounter{partnum}
        \item[{\Large \textcircled{\small\sffamily #1}}~(\thepartnum)]
    }
}

\newcommand{\crow}[1]{%
    \ifthenelse{%
        \isin{\includegraphics}{#1}
    }{%
        #1%
    }{%
        \includegraphics[width=0.9\linewidth]{#1}
    }
}

\newcommand{\minigraphics}[3][2]{%
    \begin{minipage}[#1]{#2\linewidth}%
        \adjustbox{valign=t}{\crow{#3}}
    \end{minipage}
}

\newenvironment{coneparchoices}{%
    \vspace{5pt}
    \hspace{1.5pt}
    \begin{enumerate*}[itemjoin = \hspace{10pt},label=(\Alph*)]%
}{%
    \end{enumerate*}
} 

\newenvironment{cchoices}{%
    \vspace{-5pt}
    \begin{enumerate}[label=(\Alph*)]%
}{%
    \end{enumerate}
}

\newcommand{\cminiset}[4]{%
    \begin{minipage}[t]{#1\linewidth}
        #2
        
        \begin{oneparchoices}
            #3
        \end{oneparchoices}
    \end{minipage}
    \FPeval{\result}{0.98-#1}
    \hfill
    \begin{minipage}[t]{\result\linewidth}
        \adjustbox{valign=t}{\crow{#4}}
    \end{minipage}
}

\newcommand{\miniset}[3]{%
    \begin{minipage}[t]{#1\linewidth}
        #2
    \end{minipage}
    \FPeval{\result}{0.98-#1}
    \hfill
    \begin{minipage}[t]{\result\linewidth}
        \adjustbox{valign=t}{\crow{#3}}
    \end{minipage}
}

\newcommand{\tminiset}[3]{%
    \begin{minipage}[t]{#1\linewidth}
        #2
    \end{minipage}
    \FPeval{\result}{0.98-#1}
    \hfill
    \begin{minipage}[t]{\result\linewidth}
        \adjustbox{valign=t}{\resizebox{\linewidth}{!}{#3}}
    \end{minipage}
}

\newcommand{\cxminiset}[4]{%
    \begin{minipage}[t]{#1\linewidth}
        #2
        \begin{choices}
            #3
        \end{choices}
    \end{minipage}
    \FPeval{\result}{0.98-#1}
    \hfill
    \begin{minipage}[t]{\result\linewidth}
        #4
    \end{minipage}
}

\newcommand{\cxfminiset}[4]{%
    \begin{minipage}[t]{#1\linewidth}
        #2
        
        \begin{choices}
            #3
        \end{choices}
    \end{minipage}
    \FPeval{\result}{0.98-#1}
    \hfill
    \begin{minipage}[t]{\result\linewidth}
        \adjustbox{valign=t}{\crow{#4}}
    \end{minipage}
}

\newcommand{\fig}[1]{%
    \adjustbox{valign=t,center, nofloat=figure}{#1}
}

\newcommand{\Fig}[1]{%
    \adjustbox{valign=t,center, nofloat=figure}{#1}
}

\newcommand{\comeout}{\hspace{-20pt}}

\newcommand{\fillin}{\ \rule{1.5cm}{0.5pt}\ }

\newcommand{\wrong}[1]{\textbf{\CJKunderdblline{#1}}}