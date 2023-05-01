if (!require("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

BiocManager::install("RTCGA.clinical", INSTALL_opts = '--no-lock')
BiocManager::install("RTCGA")
install.packages("tidyverse")

library(RTCGA)
library(RTCGA.clinical)
library(tidyverse)

LUAD <- LUAD.clinical[c("admin.disease_code", "patient.bcr_patient_barcode", "patient.drugs.drug.therapy_types.therapy_type", 
                        "patient.stage_event.pathologic_stage", "patient.samples.sample.sample_type",
                        "patient.age_at_initial_pathologic_diagnosis", "patient.gender", "patient.race")]
LUAD$patient.bcr_patient_barcode = toupper(LUAD$patient.bcr_patient_barcode)
colnames(LUAD) <- c("tumor", "barcode", "therapy", "stage", "type", "age", "gender", "race")
LUAD_survival <- survivalTCGA(LUAD.clinical)
colnames(LUAD_survival) <- c("OS.time", "barcode", "OS")
LUAD <- full_join(LUAD, LUAD_survival, by = "barcode")
LUAD <- LUAD[-which(is.na(LUAD$OS)),]

SKCM <- SKCM.clinical[c("admin.disease_code", "patient.bcr_patient_barcode", "patient.drugs.drug.therapy_types.therapy_type", 
                        "patient.stage_event.pathologic_stage", "patient.samples.sample.sample_type",
                        "patient.age_at_initial_pathologic_diagnosis", "patient.gender", "patient.race")]
SKCM$patient.bcr_patient_barcode = toupper(SKCM$patient.bcr_patient_barcode)
colnames(SKCM) <- c("tumor", "barcode", "therapy", "stage", "type", "age", "gender", "race")
SKCM_survival <- survivalTCGA(SKCM.clinical)
colnames(SKCM_survival) <- c("OS.time", "barcode", "OS")
SKCM <- full_join(SKCM, SKCM_survival, by = "barcode")
SKCM <- SKCM[-which(is.na(SKCM$OS)),]

HNSC <- HNSC.clinical[c("admin.disease_code", "patient.bcr_patient_barcode", "patient.drugs.drug.therapy_types.therapy_type", 
                        "patient.stage_event.pathologic_stage", "patient.samples.sample.sample_type",
                        "patient.age_at_initial_pathologic_diagnosis", "patient.gender", "patient.race")]
HNSC$patient.bcr_patient_barcode = toupper(HNSC$patient.bcr_patient_barcode)
colnames(HNSC) <- c("tumor", "barcode", "therapy", "stage", "type", "age", "gender", "race")
HNSC_survival <- survivalTCGA(HNSC.clinical)
colnames(HNSC_survival) <- c("OS.time", "barcode", "OS")
HNSC <- full_join(HNSC, HNSC_survival, by = "barcode")
HNSC <- HNSC[-which(is.na(HNSC$OS)),]

Subin <- rbind(HNSC, LUAD, SKCM)
