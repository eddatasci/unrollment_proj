## The Unrollment Project: Exploring Algorithmic Bias in Higher Education

This symposium will provide an overview and a discussion of our
ongoing project exploring the use of predictive algorithms in higher
education decisionmaking.  In this project team members use an open
source platform to provide transparency around how predictive
algorithms in higher education are estimated and how decisions made on
the basis of these algorithms might affect currently marginalized
students in higher education. Predictive algorithms have taken on an
important role in decisionmaking in higher education, and have clear
implications for participation for all (Eduventures, 2013; Ekowo &
Palmer 2016). This project seeks to demistify how these algorithms
work and to create a more open discussion about how these predictive
models might affect participation in higher education.

Administrators in colleges and universities in the United States have
made increasing use of predictive algorithms for decision-making
(Scholes, 2016; Slade, 2013). College staff many times use these
algorithms to predict which students will enroll in a given campus,
and which students will complete a degree once enrolled (Ekowo and
Palmer, 2016). Once students are assigned either a predicted
probability of an outcome or a predicted classification, different
decisions can be made about how the institution will work with that
student (Klempin et al, 2018). For instance, students who are less
likely to enroll may be offered less financial aid, as those funds
could be targeted on students who are more likely to
enroll. Similarly, administrators may be less likely to admit a
student when predictive algorithms suggest that the student has a low
probability of completing a degree.

In this project we explore possible biases in predictive models that
could be used to predict access and success in higher education
(Lambrecht & Tucker, 2019; Sweeney, 2013). As a
result of this work we hope to provide transparency around how
predictive algorithms are generated and how decisions made on the
basis of these algorithms might affect currently marginalized groups
in higher education.

In the first stage we use publicly available data from the publicly
available longitudinal studies and a model development framework based
on the “tidymodels” package in the statistical programming language R
to evaluate the predictive accuracy of different modeling approaches,
including logistic regression, elastic-net logistic regression, random
forests, and neural networks (Kuhn & Wickham, 2019; Kuhn & Johnson,
2013; Hastie, et al 2009).  The “tidymodels” framework allows for a
start-to-finish data science pipeline from data wrangling through
modeling to cross validation of results (Kuhn & Wickham, 2019). In the second stage we
simulate the predicted impact of different decision-making frameworks
based on the results of predictions from the first stage, with a
particular focus on how these results might affect currently
marginalized groups in higher education (Williams et al 2018).

The following panelists will present during the course of the symposium.

*Patricia Martin, doctoral student at UCLA* and investigator with the
Enrollment Management, Recruiting and Access Group, will provide an
overview of the Unrollment Project, including both the substantive
goals of the project and the process for undertaking research. The
Unrollment project has an unusual structure for higher education
research, where all data and code are publicly available, and research
can be followed in "real time" as researchers post their results and
discussions to GitHub, an open repository for code.  The project
itself has several current key milestones, including the development
of predictive algorithms for college completion; simulation of
decision-making based on these algorithms; and calculating likely
impacts for different groups of students based on these
milestones. Martin will introduce the use of git and GitHub as a
model for open-source research collaborations that are available to
the public in development, and will demonstrate how audience members
can provide input and feedback to the research team as the work
progresses. 

*Monique Ositelu, Senior Policy Analyst at the New America Foundation*,
will discuss her work on the implications of using predictive
algorithms for individual institutions. These case studies of
institutional decision-making will provide concrete examples of how
predictive algorithms influence administrators' decision-making and
thereby impacting students' chances of success.  This analysis
evaluates the equity impacts of predictive analytics on enrollment
management within higher education. In particular, we evaluate the
unintended consequences of predictive analytics and implications on
access for students of color and low-income students. We identify how
sectors of higher education institutions are differentially affected
by using algorithms for predicting enrollment and graduation. We
identify which sectors reinforce existing inequities and limit access
to higher education for underserved populations.

The sectors we will evaluate are 4-year public and 4-year private
institutions, as well as Historically Black Colleges & Universities
(HBCUs). We are selecting 4-year institutions because of the dominant
presence of enrollment management within this particular sector. While
private institutions have more discretion in the development and
execution of institutional policies; public colleges have a unique
commitment to provide access to higher education regionally, in which
additional barriers to access -- such as enrollment management -- may
jeopardize public institutions’ role within their region. Since HBCUs
historically have a mission to enroll underserved populations, such as
students of color, including this variation of 4-year institutions
will provide an opportunity to compare institutional profiles of the
types of sectors that may perpetuate inequities in accessing higher
education with enrollment management tools.

In response to the coronavirus, we anticipate that algorithms for
enrollment management will shift to include non-traditional variables
in attempts to accurately predict students’ enrollment behavior. For
that reason, the analysis includes a mixed methods approach of
semi-formal interviews with enrollment management vendors to identify
how changes in enrollment management models may further exacerbate the
inequities we gather from the quantitative analysis. Although we are
using secondary data collected prior to the coronavirus pandemic,
through a mixed-methods approach, we will develop implications on how
vendors and institutions are perpetuating inequities to access higher
education in the wake of COVID-19.

*Karina Salazar, Assistant Professor of Higher Education* at the
University of Arizona, will discuss how the unrollment project builds
on her previous work regarding spatial discrimination in college
recruiting, and how the use of data analysis can reveal inequalities
in how colleges recruit and retain students.   

*Ben Skinner, Assistant Professor of Higher Education and Policy* at
the University of Florida, will discuss the results of the first stage
of the project, which involves generating predictive algorithms for
bachelor's degree completion among recent high school graduates
attending four-year institutions. The data for this part of the study
come from the Educational Longitudinal Study of 2002 (Ingels, et al
2014). Using this data, the project predicts college graduation based
on a large set of covariates, using four different modeling
approaches: logistic regression, elastic-net logistic regression,
random forests and neural nets (Hastie et al, 2009). Skinner will
summarize the results of these models, including both standard
measures of model fit and summaries of the substantive
importance of these different measures of fit.   

*Will Doyle, Professor of Higher Education at Vanderbilt University*,
will introduce the panelists and moderate discussions. To provide for
maximum interactivity, Doyle will moderate brief discussions
immediately after each panelist's presentation, with time also
reserved for discussion at the end. Attendees will be encouraged to
access all of the materials made available by the team on GitHub and
to provide their input and recommendations for the project as it
proceeds. 

References:

Eduventures (2013). “Predictive Analytics in Higher Education:
Data-Driven Decision-Making for the Student Life
Cycle” Boston, MA: Eduventures.

Ekowo, M., & Palmer, I. (2016). Predictive analytics in higher
education: Five guiding principles for ethical use. Washington, DC:
New America Foundation.

Ekowo, M., & Palmer, I. (2016). The Promise and Peril of Predictive
Analytics in Higher Education: A Landscape Analysis. Washington, DC:New America.

Hastie, T., Tibshirani, R., & Friedman, J. (2009). The elements of
statistical learning: data mining, inference, and prediction. Springer
Science & Business Media.

Ingels, S.J., Pratt, D.J, Alexander, C.P., Jewell, D.M., Lauff,
E. Mattox, T.L., and Wilson, D. (2014). Education Longitudinal Study
of 2002 Third Follow-up Data File Documentation (NCES
2014-364). National Center for Education Statistics, Institute of
Education Sciences, U.S. Department of Education. Washington,
DC. Retrieved from http://nces.ed.gov/pubsearch.

Klempin, S. C., Grant, M. N., & Ramos, M. (2018). Practitioner
Perspectives on the Use of Predictive Analytics in Targeted Advising
for College Students. New York: Community College Research Center

Kuhn, M., & Johnson, K. (2013). Applied predictive modeling
(Vol. 26). New York: Springer.

Kuhn, M. & Wickham, H. (2019). tidymodels: Easily Install and Load the
 'Tidymodels' Packages. R package version 0.0.3.  Retrieved from
 https://CRAN.R-project.org/package=tidymodels

Lambrecht, A., & Tucker, C. (2019). Algorithmic bias? an empirical
study of apparent gender-based discrimination in the display of stem
career ads. Management Science, 65(7), 2966-2981.

Mittelstadt, B. D., Allo, P., Taddeo, M., Wachter, S., & Floridi,
L. (2016). The ethics of algorithms: Mapping the debate. Big Data &
Society, 3(2) 1-21.

Prinsloo, P., & Slade, S. (2014). Educational triage in open distance
learning: Walking a moral tightrope. International Review of Research
in Open and Distributed Learning, 15(4), 306-331.

Salazar, K. G. (2019). The Wealth and Color of Off-Campus Recruiting
by Public Research Universities.

Salazar, K., Jaquette, O., & Han, C. (2019). Coming soon to a
neighborhood near you? Offcampus recruiting by public research
universities.

Scholes, V. (2016). The ethics of using learning analytics to categorize students on risk. Educational Technology Research and Development, 64(5), 939-955.

Slade, S., & Prinsloo, P. (2013). Learning analytics: Ethical issues and dilemmas. American Behavioral Scientist, 57(10), 1510-1529.

Sweeney, L. (2013). Discrimination in online ad delivery. Queue, 11(3), 10-29.

Williams, B. A., Brooks, C. F., & Shmargad, Y. (2018). How algorithms discriminate based on data they lack: Challenges, solutions, and policy implications. Journal of Information Policy, 8, 78-115.




