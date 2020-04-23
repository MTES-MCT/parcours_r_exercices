# Réaliser un facette sur un diagramme barre avec :
#   
#   - en variable discrète les régions
#   - en variables continues les indicateurs suivants :
#         - % de logements de 3 et 4 pièces
#         - % DPE énergie A,B,C
#         - % DPE GES A,B,C
#         - % de parc de moins de 5 ans
#   - une façon d’identifier la région Pays de la Loire
# 

load("exdata/rpls_aggrege.RData")

rpls_aggrege  %>% 
  filter(TypeZone=="Régions",
         Indicateur %in% c("3 et 4 pièces_pourcent",
                           "DPE GES classe ABC_pourcent",
                           "DPE énergie classe ABC_pourcent",
                           "Parc de moins de 5 ans_pourcent")) %>% 
  mutate(Indicateur=fct_recode(Indicateur,
                               `Logements de 3 et 4 pièces`="3 et 4 pièces_pourcent",
                               `Logements avec DPE énergie de classe A,B,C`="DPE énergie classe ABC_pourcent",
                               `Logements avec DPE GES de classe A,B,C`="DPE GES classe ABC_pourcent",
                               `Logements social de moins de 5 ans`="Parc de moins de 5 ans_pourcent"),
         r52=ifelse(Reg_2017=="52",1,0)) %>% 
  ggplot()+
  #On utilise l'indicatrice de la région Pays de la Loire pour mapper la transparence
  geom_bar(aes(x=nReg_2017,weight=Valeur,fill=Indicateur,alpha=r52))+
  coord_flip()+
  theme_minimal()+
  scale_fill_ipsum()+
  #On défini les valeurs maximum et minimum de transparence que l'on veut voir
  scale_alpha_continuous(range=c(.65,1))+
  facet_wrap(~Indicateur)+
  theme(legend.position="none")+
  labs(title="mon premier facet",y="En % du parc social",x="")
