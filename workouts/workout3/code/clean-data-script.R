##############
## raw data ##
##############
Sys.sleep(15)
url1 <- "https://raw.githubusercontent.com/ucb-stat133/stat133-fall-2019/master/data/scholar/paul_romer_GoogleScholarCitations.html"
all_nodes1 <- read_html(url1)
url2 <- "https://raw.githubusercontent.com/ucb-stat133/stat133-fall-2019/master/data/scholar/william_nordhaus_GoogleScholarCitations.html"
all_nodes2 <- read_html(url2)

#################
## #Paul Romer ##
#################
table_nodes1 <- all_nodes1 %>%
  html_nodes(xpath = '//*[@id="gsc_a_b"]') %>%
  html_nodes(xpath = 'tr') %>%
  html_nodes(xpath = 'td')
children_nodes1 <- html_children(table_nodes1)
children_text1 <- html_text(children_nodes1)
refined_children_text1 <- children_text1[children_text1 != '*']
papers1 <- c(refined_children_text1[seq(from = 1, to = 1126, by = 5)])
authors1 = c(refined_children_text1[seq(from = 2, to = 1127, by = 5)])
journals1 = c(refined_children_text1[seq(from = 3, to = 1128, by = 5)])
citations1 = c(refined_children_text1[seq(from = 4, to = 1129, by = 5)])
years1 = c(refined_children_text1[seq(from = 5, to = 1130, by = 5)])
dat1 <- data.frame("paperName" = papers1, "researcher" = authors1, "journal" = journals1, "citations" = citations1, "year" = years1,stringsAsFactors = FALSE)

######################
## William Nordhaus ##
######################
table_nodes2 <- all_nodes2 %>%
  html_nodes(xpath = '//*[@id="gsc_a_b"]') %>%
  html_nodes(xpath = 'tr') %>%
  html_nodes(xpath = 'td')
result = sapply(html_children(table_nodes2), html_text)
result = result[result != '*']
citation_df = data.frame(article_title = result[seq(1, length(result), 5)],
                         author = result[seq(2, length(result), 5)],
                         journal = result[seq(3, length(result), 5)],
                         citations = result[seq(4, length(result), 5)],
                         year = result[seq(5, length(result), 5)])

########################
## Exporting CSV file ##
########################
write.csv (dat1, file = "Paul Romer_GoogleScholarCitations.csv", row.names = FALSE)
write.csv (citation_df, file = "William Nordhaus_GoogleScholarCitations.csv", row.names = FALSE)

