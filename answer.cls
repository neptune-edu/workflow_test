\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{answer}

\input{pyp_base.cls}

%%%%% New Features %%%%%

\newcommand{\subject}[1]{%
    \setcounter{section}{0}
    \par
    \noindent\makebox[\linewidth]{\color{black!70}{\rule{\linewidth}{0.4pt}}}
    \vspace{-1.3em}
    
    \noindent{\Large \textbf{\hfill #1\hfill}}
    \labeltext{#1}{sub-\thetextnumber}
    
    \vspace{-0.7em}
    \noindent\makebox[\linewidth]{\color{black!70}{\rule{\linewidth}{0.4pt}}}
    \par
}

\newcommand{\Stars}[2][fill=black,draw=black]{ % \Stars for difficulty
    \begin{tikzpicture}[baseline=-0.35em,#1]
        \foreach \X in {1,...,5}
        {\pgfmathsetmacro{\xfill}{min(1,max(1+#2-\X,0))}
        \path (\X*1.1em,0) 
        node[star,draw,star point height=0.25em,minimum size=1em,inner sep=0pt,
        path picture={\fill (path picture bounding box.south west) 
        rectangle  ([xshift=\xfill*1em]path picture bounding box.north west);}]{};
        }
    \end{tikzpicture}
}

\makeatletter % labeltext; \labeltext{text}{label number}
\newcommand{\labeltext}[2]{%
    \@bsphack
    \csname phantomsection\endcsname % in case hyperref is used
    \def\@currentlabel{#1}{\label{#2}}%
    \@esphack
}
\makeatother

\MakeRobust{\ref} % avoid expanding it when in a textual label; no idea what is this for

% Counter: textnumber, number, piper, lastnumber

\newtotcounter{textnumber} % counting number of sections and questions; with 100 increment
\setcounter{textnumber}{0}

\newcounter{number}

% Environment questions: an enumerating environment for questions.
% label: 1., 2., ...
% label for sections: sec-\thetextnumber
% value of number: enumi
% after environment: textnumber + 100

\newenvironment{questions}{%
    \label{sec-\thetextnumber}
    \begin{enumerate}[label=\arabic*.\ , leftmargin=35pt,listparindent=20pt]
    \setcounter{number}{0}
}{%
    \setcounter{number}{\value{enumi}}
    \end{enumerate}
    \addtocounter{textnumber}{100}
}

% Environment cquestions: an enumerating environment for questions that needs continual numbering.
% label: 1., 2., ...
% label for sections: sec-\thetextnumber
% value of number: enumi
% after environment: textnumber + 100

\newenvironment{cquestions}{
    \label{sec-\thetextnumber}
    \begin{enumerate}[label=\arabic*.\ , leftmargin=35pt,listparindent=20pt]
    \setcounter{enumi}{\value{number}}
}{
    \end{enumerate}
    \setcounter{enumi}{0}
    \addtocounter{textnumber}{100}
}

% Command question: label every question
% textnumber + 1
% number + 1
% labeltext: {\theenumi}{lab-\thetextnumber}

\newcommand{\question}{%
    \stepcounter{textnumber}
    \item 
    \labeltext{\theenumi}{lab-\thetextnumber} 
    \stepcounter{number}
}

\newcounter{choice}
\renewcommand\thechoice{(\arabic{choice})}
\ifthenelse{\boolean{@isScience}}{
        \renewcommand\thechoice{(\Alph{choice})}
    }{
        \renewcommand\thechoice{(\arabic{choice})}
    }
\newcommand\choicelabel{\thechoice}

\newenvironment{choices}{%
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
}{%
    \endlist
}

\newenvironment{oneparchoices}{% horizontal choices in MCQs; alternative version of tasks
    \leavevmode
    \hspace{-19pt}
    \begin{enumerate*}[itemjoin = \hspace{10pt},label=(\arabic*)]
}{%
    \end{enumerate*}
}

\newcommand{\choice}{\item}

\newenvironment{parts}{% subquestions
    \begin{enumerate}[label=(\arabic*)]
}{
    \end{enumerate}
}

\renewcommand{\part}{\item}

\newcommand{\sprout}[1]{\labeltext{#1}{ques-\thetextnumber}} % produce text in the answersheet

\newcommand{\nextitem}{~~} % use in sprout

% Command xanswer, etc.: provide template to write answers. 
% label of answer: {answer; whatever you write inside}{ques-\thetextnumber}

\newcommand{\onlyanswer}[2]{%
    【解答】\labeltext{#1}{ques-\thetextnumber}\ref{ques-\thetextnumber} \par\noindent
    【難度】\hspace{-3pt}\Stars{#2}
}

\newcommand{\xanswer}[4]{%
    【解答】\labeltext{#1}{ques-\thetextnumber}\ref{ques-\thetextnumber} \par\noindent
    【難度】\hspace{-3pt}\Stars{#2}\par\noindent
    【詳解】#3 \par\noindent
    【補充】#4
}

\newcommand{\answer}[3]{%
    【解答】\labeltext{#1}{ques-\thetextnumber}#1 \par\noindent
    【難度】\hspace{-3pt}\Stars{#2}\par\noindent
    【詳解】#3
}
    
\newcommand{\panswer}[2]{%
    【難度】\hspace{-3pt}\Stars{#1}\par\noindent
    【證明】#2 \QED
}

\newcommand{\xpanswer}[3]{%
    【難度】\hspace{-3pt}\Stars{#1}\par\noindent
    【證明】#2 \QED \par\noindent
    【補充】#3
}
    
\newcommand{\eanswer}[2]{%
    \labeltext{見詳解}{ques-\thetextnumber}
    【難度】\hspace{-3pt}\Stars{#1}\par\noindent
    【詳解】#2
}

\newcommand{\exanswer}[3]{%
    \labeltext{見詳解}{ques-\thetextnumber}
    【難度】\hspace{-3pt}\Stars{#1}\par\noindent
    【詳解】#2
    【補充】#3
}

\newcommand{\onlyanswernl}[2]{%
    【解答】#1 \par\noindent
    【難度】\hspace{-3pt}\Stars{#2}
}

\newcommand{\xanswernl}[4]{%
    【解答】#1 \par\noindent
    【難度】\hspace{-3pt}\Stars{#2}\par\noindent
    【詳解】#3 \par\noindent
    【補充】#4
}

\newcommand{\answernl}[3]{%
    【解答】#1 \par\noindent
    【難度】\hspace{-3pt}\Stars{#2}\par\noindent
    【詳解】#3
}
    
\newcommand{\panswernl}[2]{%
    【難度】\hspace{-3pt}\Stars{#1}\par\noindent
    【證明】#2 \QED
}
    
\newcommand{\xpanswernl}[3]{%
    【難度】\hspace{-3pt}\Stars{#1}\par\noindent
    【證明】#2 \QED \par\noindent
    【補充】#3
}
    
\newcommand{\eanswernl}[2]{%
    【難度】\hspace{-3pt}\Stars{#1}\par\noindent
    【詳解】#2
}
    
\newcommand{\exanswernl}[3]{%
    【難度】\hspace{-3pt}\Stars{#1}\par\noindent
    【詳解】#2
    【補充】#3
}

% Command mylabel, subject & llabel: showing the answer in the answersheet.

\makeatletter
\newcommand{\mylabel}[1]{
    \@ifundefined{r@#1}{%
        \par\noindent
        {%
            \normalsize
            \addtocounter{piper}{99}
            \sublabel{sub-\thepiper}
            \textbf{%
                \ref{sec-\thepiper}、\nameref{sec-\thepiper}
            }
            \noindent
        }%
        \par\noindent
    }{%
        \hspace{-5pt}\ref{#1}
        \tab
    }
}
\makeatother

\makeatletter
\newcommand{\sublabel}[1]{
    \@ifundefined{r@#1}{%
    }{%
        \adjustbox{center, vspace = -10pt 0pt}{
            \large \textbf{\ref{#1}}
        }
        
        \hspace{-10pt}
    }
}
\makeatother

\makeatletter
\newcommand{\llabel}[1]{
    \@ifundefined{r@#1}{%
        % do nothing
    }{%
        \ref{#1}
    }
}
\makeatother

% Command answersheet: generate the answer table.
% Counter lastnumber: the value of the last question.
% Counter piper: tracking variable.

\newcommand{\answersheet}{
    \begin{center}
        \Large \textbf{簡答}
    \end{center}
    \vspace{10pt}
    \NumTabs{5}
    \newcounter{piper}
    \setcounter{piper}{1}
    \newcounter{lastnumber}
    \setcounter{lastnumber}{\totvalue{textnumber}}
    \addtocounter{lastnumber}{-99}
    {%
        \sublabel{sub-0}
        
        \textbf{\ref{sec-0}、\nameref{sec-0}}
        
        \hspace{-2pt}
        \loop
            {%
                \small
                \llabel{lab-\thepiper}
                \hspace{-7pt}
                \mylabel{ques-\thepiper}
            }
            \stepcounter{piper}
            % \tab
            \ifnum \value{piper} < \value{lastnumber}
        \repeat
    }
}

% Command helloworld: generate the title

\newcommand{\helloworld}[4]{
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
        #4能力檢定~思路與詳解
        \vspace*{\fill}
    \end{minipage}
    \hrule 
    \vspace{5pt}
    \hfill
    \textbf{\large 版權所有．翻印必究}
    \hfill
    \vspace{5pt}
    \hrule
    \answersheet
    \vspace{5pt}
    \hrule
}
%%%%%%%%%%