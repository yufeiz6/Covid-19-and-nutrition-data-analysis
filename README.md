# Project Brainstorm - Domain of Health

TA Yunwei Liang
Section BC
Group Member: Crystal Wen, Shaosui Hong, Yufei Zhang, Xinyu Wang

## Domain of Interest

> We are interested in the domain of **Health**, and our subdomain is **Nutrition**. Because we are in a situation where we are required to stay home. During the coronavirus epidemic, maintaining a healthy and strong body became the priority and it should always be. Therefore, adopting a healthy diet is more necessary than ever.  Moreover, as restaurants are only taking to-go orders, more and more people have decided to cook for themselves, acknowledging the nutrients for each food item would be helpful.

### Examples of other data driven projects related to this domain: 

- [Meal Frequency and Timing Are Associated with Changes in Body Mass Index in Adventist Health Study 2](https://academic.oup.com/jn/article/147/9/1722/4743530) 
Since scientific evidence for the optimal number, timing, and size of meals are lacking, the authors of this study investigated the relation between meal frequency and timing and changes in body mass index (BMI).

- [Effects of red meat, white meat, and non-meat protein sources](https://academic.oup.com/ajcn/article/110/1/24/5494812)
The authors of the study tested whether levels of atherogenic lipids and lipoproteins differed significantly following consumption of diets with high red meat content compared with diets with similar amounts of protein derived from white meat or non-meat sources.

- [Association Between Organic Food Consumption and Breast Cancer Risk](https://academic.oup.com/cdn/article/3/Supplement_1/nzz039.P18-038-19/5517295) 
Organic food consumption may lower cancer risk, possibly due to decreased exposure to pesticides. The authors of the study have investigated the association between organic food consumption and cancer risk.

### After the research, we come up with some question within the domain:

- How is a healthy eating diet related to combating the coronavirus? 

- What should we eat to maintain a healthy diet? Or What should we eat to maintain health?

- What is the relationship between obesity and the chance of COVID-19 infection?

### In order to answer the questions above, we need to analyze data. Here are some logic to answer the questions:

- In response to question1, we could collect data on the eating habits of people from each country. Then, we should find the percentage of people who are confirmed of COVID-19 and the percentage of people who have recovered from COVID-19. Then we put all those data together into a dataset.Besides, we compare the confirmed rate of those with good eating habits to those with bad eating habits to find the correlation between diet and the chance of infection.

- In response to question2, to find how we should eat to maintain a healthy diet, we could compare the calories, protein, vitamins, etc. of the different foods. Moreover, we could compare the calories in each food to the standard amount of calories that a human should eat per day.

- In response to question3, we could find the percentage of obesity in each country; then, we could find the percentage of COVID confirmed cases out of the country population. After that, we could put together those two columns and make a comparison between countries. 

## Finding Data

### Following what mentioned above, we find several datasets which are useful for answering the qeustions.

#### 1. [**Emoji Diet Nutritional Data**](https://www.kaggle.com/ofrancisco/emoji-diet-nutritional-data-sr28)

- The host of the data collected the data from the amazing [emojipedia](https://emojipedia.org/food-drink/) and handpicked the nutritional value from the [USDA](https://fdc.nal.usda.gov/fdc-app.html#/?query=ndbNumber:9038) Food Composition Database using its food search feature.

- There are 58 Observations(rows); 35 Features(columns) in the dataset.

- The question "What should we eat to maintain health?" can be answered.

#### 2. [**COVID-19 Healthy Diet Dataset**](https://www.kaggle.com/mariaren/covid19-healthy-diet-dataset)

- Data for different food group supply quantities, nutrition values, obesity, and undernourished percentages are obtained from Food and [Agriculture](http://www.fao.org/faostat/en/#home) Organization of the United Nations.
Data for population count for each country comes from Population Reference Bureau PRB website. 
- Data for COVID-19 confirmed, deaths, recovered and active cases are obtained from Johns Hopkins Center for Systems Science and Engineering [CSSE](https://coronavirus.jhu.edu/map.html) website. 
- Data for population count for each country comes from Population Reference Bureau [PRB](https://www.prb.org/) website
- The USDA Center for Nutrition Policy and Promotion diet intake guideline information can be found in [ChooseMyPlate.gov](https://www.choosemyplate.gov/)
- There are 171 Observations(rows); 32 Features(columns) in the Fat_Supply_Quantity_Data.
- There are 171 Observations(rows); 32 Features(columns) in the Food_Supply_kcal_Data.
- There are 171 Observations(rows); 32 Features(columns) in the Food_Supply_Quantity_kg_Data.
- There are 171 Observations(rows); 32 Features(columns) in the Protein_Supply_Quantity_Data.
- The question "How is a healthy eating diet related to combating the coronavirus?" and "What is the relationship between obesity and the chance of COVID-19 infection?" can be answered.

#### 3. [**Nutritional values for common foods and products**](https://www.kaggle.com/trolukovich/nutritional-values-for-common-foods-and-products)

- Data was collected from this [website](https://www.nutritionvalue.org/), by web scraping.

- There are 298 Observations(rows); 77 Features(columns) in this dataset.

- The question "What should we eat to maintain a healthy diet?" can be answered by this dataset.