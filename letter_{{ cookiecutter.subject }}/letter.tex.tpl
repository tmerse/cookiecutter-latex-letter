\documentclass%%
  [fontsize=11pt,%%          Schriftgroesse
   paper=a4,%%               Papierformat
% Layout
   headsepline=off,%%        Linie unter der Seitenzahl
   parskip=half,%%           Abstand zwischen Absaetzen
% Was kommt in den Briefkopf und in die Anschrift
   fromalign=right,%%        Plazierung des Briefkopfs
{%- if (cookiecutter.phone == 'n' or not cookiecutter.phone) %}
   fromphone=off,%%          Telefonnummer im Absender
{%- else %}
   fromphone=on,%%           Telefonnummer im Absender
{%- endif %}
   fromrule=aftername,%%     Linie im Absender (aftername, afteraddress)
   fromfax=off,%%            Faxnummer
   fromemail=on,%%           Emailadresse
   fromurl=off,%%            Homepage
   fromlogo=on,%%            Firmenlogo
   addrfield=on,%%           Adressfeld fuer Fensterkuverts
   backaddress=on,%%         ...und Absender im Fenster
   subject=beforeopening,%%  Plazierung der Betreffzeile
   locfield=narrow,%%        zusaetzliches Feld fuer Absender
   foldmarks=on,%%           Faltmarken setzen
   numericaldate=off,%%      Datum numerisch ausgeben
   refline=narrow,%%         Geschaeftszeile im Satzspiegel
% Formatierung
   draft=off%%              Entwurfsmodus
]{scrlttr2}

\usepackage[english, ngerman]{babel}
\usepackage{url}
\usepackage{lmodern}
\usepackage[utf8]{inputenc}
\usepackage{tabularx}
\usepackage{colortbl}
\usepackage{lipsum}

\usepackage{scrlayer}
\DeclareNewLayer[
  align=tl,
  hoffset=\dimexpr.5\paperwidth-.5\useplength{firstfootwidth}\relax,
  voffset=\useplength{firstfootvpos},
  width=\useplength{firstfootwidth},
  height=\dimexpr\paperheight-\useplength{firstfootvpos},
  foreground,
  contents={\parbox{\layerwidth}{\usekomavar{firstfoot}}}
]{myfoot.fg}
\DeclarePageStyleByLayers{myletter}{myfoot.fg}
\pagestyle{myletter}

\usepackage[a4paper]{geometry}
\geometry{verbose,bmargin=0cm}

% symbols: (cell)phone, email
\RequirePackage{marvosym} % for gray color in header
\usepackage[T1]{fontenc}

% Schriften werden hier definiert
\renewcommand*\familydefault{\sfdefault} % Latin Modern Sans
\setkomafont{fromname}{\sffamily\color{mygray}\LARGE}
\setkomafont{subject}{\mdseries}
\setkomafont{backaddress}{\mdseries}
\setkomafont{fromaddress}{\small\sffamily\mdseries\color{mygray}}

% Do not write unnecessary files
\nofiles
\begin{document}

% Briefstil und Position des Briefkopfs
\LoadLetterOption{DIN} %% oder: DINmtext, SN, SNleft, KOMAold.
\makeatletter
\@setplength{sigbeforevskip}{10mm}        % Abstand der Signatur von dem closing
\@setplength{firstheadvpos}{17mm}         % Abstand des Absenderfeldes vom Top
\@setplength{firstfootvpos}{275mm}        % Abstand des Footers von oben
\@setplength{firstheadwidth}{\paperwidth}
\@setplength{locwidth}{70mm}              % Breite des Locationfeldes
\@setplength{locvpos}{65mm}               % Abstand des Locationfeldes von oben
\ifdim \useplength{toaddrhpos}>\z@
  \@addtoplength[-2]{firstheadwidth}{\useplength{toaddrhpos}}
\else
  \@addtoplength[2]{firstheadwidth}{\useplength{toaddrhpos}}
\fi
\@setplength{foldmarkhpos}{6.5mm}
\makeatother

\definecolor{mygray}{gray}{.55}
\definecolor{myblue}{rgb}{0.25,0.45,0.75}

% Sender
\setkomavar{fromname}
  {{ "{" + cookiecutter.full_name + "}" }}

\setkomavar{fromaddress}
  {{ "{" + cookiecutter.street }}\\
  {{ cookiecutter.zip + "}" }}

\setkomavar{fromphone}[\Mobilefone~]
  {{ "{" + cookiecutter.phone|replace(' ', '\,') + "}" }}

\setkomavar{fromemail}[\Letter~]
  {{ "{" + cookiecutter.email + "}" }}

\setkomavar{backaddressseparator}{ - }
\setkomavar{signature}
  {{ "{" + cookiecutter.full_name + "}" }}

\renewcommand*{\raggedsignature}{\raggedright}
\setkomavar{location}{\raggedleft}
\renewcommand{\enclname}{Anlagen}
\setkomavar{enclseparator}{: }


\pagenumbering{arabic}

\firstfoot{\footnotesize%
\rule[3pt]{\textwidth}{.4pt} \\
\begin{tabular}[t]{l@{}}%
    \usekomavar{fromname}\\
    \usekomavar{fromaddress}\\
\end{tabular}%
\hfill
\begin{tabular}[t]{l@{}}%
  \usekomavar[\Mobilefone~]{fromphone}\\
   \usekomavar[\Letter~]{fromemail}\\
\end{tabular}%
}%

% Bankverbindung

\setkomavar{date}
  {\today}
\setkomavar{place}
  {{ "{" + cookiecutter.city + "}" }}

\begin{letter}
  {{ "{" + cookiecutter.to_full_address + "}" }}

\setkomavar{subject}
  {{ "{\\bf{" + cookiecutter.subject + "}}" }}

\opening{Sehr geehrte Damen und Herren}

\lipsum

\closing{Mit freundlichen Grüßen}

\end{letter}
\end{document}
