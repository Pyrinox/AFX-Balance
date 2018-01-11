# AFX-Balance
*<b> WARNING: WORK IN PROGRESS. </b>* \
This gem should eventually contain a host of methods useful to the planning of logistics for large organizations.
AFX-Balance as of now is a experimental proto-gem to be used in scenarios where there exists a large population of objects (with attributes) that need to be fairly divided into specific partitions. More functionality to be added.

Example use cases:
An organization needs to create fair teams based on year and gender.

### Variables:
w = whole (e.g. the organization in question) \
p = partition (e.g. the number of teams in the organization) \
o = options (a collection of partitions; a subset of whole) \
s_w = ideal/whole balance score (e.g. the ratio of characteristics found in the whole org. The most balanced any partition can get taking into consideration the entire org) \
s_p = partition balance score (e.g. how balanced the partition is) \
s_o = options balance score (e.g. how balanced the options are) \
a = attribute (e.g. gender, year, etc.) \
a_w = attribute weight (how much emphasis to
c = characteristic (e.g. male, female, other; freshman, sophomore, junior, senior; etc.) \
r_{p,c} = ratio of a characteristic found in partition (e.g. 25 females/50 people)
r_{w,c} = ratio of a characteristic found in whole (e.g. 50 females/100 people)

### Equations:
Given options = [Partition A, Partition B, Partition C] \
use the following equation to find the balance score of this option.

<a href="https://www.codecogs.com/eqnedit.php?latex=s_o&space;=&space;\sum_{p}&space;(\sum_{a}&space;a_{w}&space;\sum_{c}(\sqrt{r_{p,&space;c}-r_{w,&space;c}}))))" target="_blank"><img src="https://latex.codecogs.com/gif.latex?s_o&space;=&space;\sum_{p}&space;(\sum_{a}&space;a_{w}&space;\sum_{c}(\sqrt{r_{p,&space;c}-r_{w,&space;c}}))))" title="s_o = \sum_{p} (\sum_{a} a_{w} \sum_{c}(\sqrt{r_{p, c}-r_{w, c}}))))" /></a>
