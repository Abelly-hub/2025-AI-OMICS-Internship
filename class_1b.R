#create folder
dir.create("clean_data")
dir.create("scripts")
dir.create("results")

patient_data=read.csv(file.choose())
View(patient_data)


#inspect the structure of the dataset
str(patient_data)

#summary of the dataset
summary(patient_data)


#convert gender to factor
patient_data$gender_fac <- as.factor(patient_data$gender)

#reorder factor levels manually
patient_data$gender_fac <- factor(patient_data$gender_fac,
                                  levels = c("male","female"))
levels(patient_data$gender_fac)

#convert character to numeric using () function
patient_data$gender_num <- factor(patient_data$gender_fac,
                                  levels = c("male","female"),
                                  labels = c(0,1))

#convert diagnosis to factor
patient_data$diagnosis_fac <- as.factor(patient_data$diagnosis)

#to check the levels
levels(patient_data$diagnosis_fac)
View(patient_data)

#convert smoker to factor
patient_data$smoker_fac <- as.factor(patient_data$smoker)


#creating a binary smoker variable
patient_data$smoker <- ifelse(patient_data$smoker =="Yes",1,0)


#save cleaned dataset into clean_data folder
write.csv(patient_data, file = "clean_data/patient_info_data.csv")


#save entire work-space
save.image (file = "ADEDAPO_ABEL_AYODELE_Class_1b_Assignment.RData")
