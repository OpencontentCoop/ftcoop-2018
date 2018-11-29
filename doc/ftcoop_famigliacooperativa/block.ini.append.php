<?php /*

[PushToBlock]
ContentClasses[]
ContentClasses[]=frontpage
ContentClasses[]=homepage
ContentClasses[]=area_tematica
RootSubtree=1

[General]
AllowedTypes[]
AllowedTypes[]=Singolo
AllowedTypes[]=Lista
AllowedTypes[]=Lista3
AllowedTypes[]=Eventi
AllowedTypes[]=GMapItems
AllowedTypes[]=AreaRiservata
AllowedTypes[]=HTML
AllowedTypes[]=Html3Colonne
AllowedTypes[]=FacetSearch

[FacetSearch]
Name=Ricerca a faccette
ManualAddingOfItems=disabled
CustomAttributes[]
ViewList[]
ViewList[]=default
ViewName[]
ViewName[default]=Todo Prodotti
ItemsPerRow[]


[Singolo]
Name=Oggetto singolo
NumberOfValidItems=1
NumberOfArchivedItems=0
ManualAddingOfItems=enabled
ViewList[]
ViewList[]=singolo_full
ViewList[]=singolo_box_piccolo
ViewList[]=singolo_box
ViewList[]=singolo_banner
ViewList[]=singolo_in_evidenza
ViewList[]=singolo_in_evidenza_wide
ViewName[]
ViewName[singolo_full]=Default
ViewName[singolo_box_piccolo]=Titolo del blocco o dell’oggetto, miniatura e abstract
ViewName[singolo_box]=Panel
ViewName[singolo_banner]=Banner
ViewName[singolo_in_evidenza]=In evidenza
ViewName[singolo_in_evidenza_wide]=In evidenza wide
ItemsPerRow[]
ItemsPerRow[singolo_in_evidenza_wide]=1

[Lista]
Name=Lista automatica
NumberOfValidItems=1
NumberOfArchivedItems=0
CustomAttributes[]
CustomAttributes[]=node_id
UseBrowseMode[node_id]=true
CustomAttributes[]=limite
CustomAttributes[]=elementi_per_riga
CustomAttributes[]=includi_classi
CustomAttributes[]=escludi_classi
CustomAttributes[]=ordinamento
CustomAttributes[]=livello_profondita
CustomAttributes[]=state_id
CustomAttributeNames[]
CustomAttributeNames[livello_profondita]=Livello di profondità nell'alberatura
CustomAttributeNames[limite]=Numero di elementi
CustomAttributeNames[elementi_per_riga]=Elementi per riga
CustomAttributeNames[includi_classi]=Tipologie di contenuto da includere
CustomAttributeNames[escludi_classi]=Tipologie di contenuto da escludere (alternativo rispetto al precedente)
CustomAttributeNames[ordinamento]=Ordina per
CustomAttributeNames[state_id]=Stato
CustomAttributeTypes[elementi_per_riga]=select
CustomAttributeSelection_elementi_per_riga[]
CustomAttributeSelection_elementi_per_riga[unset]=Non specificato
CustomAttributeSelection_elementi_per_riga[1]=1
CustomAttributeSelection_elementi_per_riga[2]=2
CustomAttributeSelection_elementi_per_riga[3]=3
CustomAttributeSelection_elementi_per_riga[4]=4
CustomAttributeSelection_elementi_per_riga[6]=6
CustomAttributeTypes[ordinamento]=select
CustomAttributeTypes[includi_classi]=class_select
CustomAttributeTypes[escludi_classi]=class_select
CustomAttributeSelection_ordinamento[]
CustomAttributeSelection_ordinamento[name]=Titolo
CustomAttributeSelection_ordinamento[pubblicato]=Data di pubblicazione
CustomAttributeSelection_ordinamento[modificato]=Data di ultima modifica
CustomAttributeSelection_ordinamento[priority]=Priorità del nodo
CustomAttributeTypes[state_id]=state_select
ManualAddingOfItems=disabled
ViewList[]
ViewList[]=lista_num
ViewList[]=lista_accordion
ViewList[]=lista_box
ViewList[]=lista_carousel
ViewList[]=lista_carousel_wide
ViewList[]=lista_in_evidenza
ViewList[]=lista_in_evidenza_wide
ViewList[]=lista_banner
ViewList[]=lista_panel
ViewName[]
ViewName[lista_num]=Carousel
ViewName[lista_accordion]=Accordion
ViewName[lista_box]=Elenco
ViewName[lista_carousel]=Slider
ViewName[lista_carousel_wide]=Slider wide
ViewName[lista_in_evidenza]=In evidenza
ViewName[lista_in_evidenza_wide]=In evidenza wide
ViewName[lista_banner]=Banner
ViewName[lista_panel]=Panel
TTL=3600
ItemsPerRow[]
ItemsPerRow[lista_in_evidenza]=1
ItemsPerRow[lista_in_evidenza_wide]=1
ItemsPerRow[lista_carousel]=1
ItemsPerRow[lista_carousel_wide]=1

[Lista3]
Name=Lista manuale
NumberOfValidItems=15
NumberOfArchivedItems=0
ManualAddingOfItems=enabled
CustomAttributes[]
CustomAttributes[]=elementi_per_riga
CustomAttributeNames[]
CustomAttributeNames[elementi_per_riga]=Elementi per riga
CustomAttributeTypes[elementi_per_riga]=select
CustomAttributeSelection_elementi_per_riga[]
CustomAttributeSelection_elementi_per_riga[unset]=Non specificato
CustomAttributeSelection_elementi_per_riga[1]=1
CustomAttributeSelection_elementi_per_riga[2]=2
CustomAttributeSelection_elementi_per_riga[3]=3
CustomAttributeSelection_elementi_per_riga[4]=4
CustomAttributeSelection_elementi_per_riga[6]=6
ViewList[]
ViewList[]=lista_accordion_manual
ViewList[]=lista_box
ViewList[]=lista_box2
ViewList[]=lista_tab
ViewList[]=lista_carousel
ViewList[]=lista_carousel_wide
ViewList[]=lista_in_evidenza
ViewList[]=lista_in_evidenza_wide
ViewList[]=lista_banner
ViewList[]=lista_panel
ViewName[]
ViewName[lista_accordion_manual]=Accordion
ViewName[lista_box]=Elenco ultimi 4 figli
ViewName[lista_box2]=Elenco su due colonne
ViewName[lista_tab]=Tabs
ViewName[lista_carousel]=Slider
ViewName[lista_carousel_wide]=Slider wide
ViewName[lista_in_evidenza]=In evidenza
ViewName[lista_in_evidenza_wide]=In evidenza wide
ViewName[lista_banner]=Banner
ViewName[lista_panel]=Panel
ItemsPerRow[]
ItemsPerRow[lista_in_evidenza]=1
ItemsPerRow[lista_in_evidenza_wide]=1
ItemsPerRow[lista_carousel]=1
ItemsPerRow[lista_carousel_wide]=1

[Lista4]
Name=Lista manuale (bc)
NumberOfValidItems=15
NumberOfArchivedItems=0
ManualAddingOfItems=enabled
ViewList[]
ViewList[]=lista_accordion_manual
ViewList[]=lista_box
ViewList[]=lista_box2
ViewList[]=lista_tab
ViewList[]=lista_in_evidenza
ViewName[]
ViewName[lista_accordion_manual]=Accordion
ViewName[lista_box]=Elenco
ViewName[lista_box2]=Elenco su due colonne
ViewName[lista_tab]=Schede (tab)
ViewName[lista_in_evidenza]=In evidenza

[Eventi]
Name=Eventi
NumberOfValidItems=3
NumberOfArchivedItems=0
ManualAddingOfItems=enabled
CustomAttributes[]
CustomAttributes[]=tab_title
CustomAttributeNames[tab_title]=Per il secondo tab - etichetta
CustomAttributes[]=custom_interval
CustomAttributeNames[custom_interval]=Per il secondo tab - periodo di riferimento
CustomAttributeTypes[custom_interval]=select
CustomAttributeSelection_custom_interval[]
CustomAttributeSelection_custom_interval[TOMORROW]=Domani
CustomAttributeSelection_custom_interval[TOMORROW-P1W]=Da domani per una settimana
CustomAttributeSelection_custom_interval[TOMORROW-P2W]=Da domani per due settimane
CustomAttributeSelection_custom_interval[TOMORROW-P1M]=Da domani per un mese
CustomAttributeSelection_custom_interval[TOMORROW-P2M]=Da domani per due mesi
CustomAttributeSelection_custom_interval[TODAY]=Oggi
CustomAttributeSelection_custom_interval[TODAY-P1W]=Da oggi per una settimana
CustomAttributeSelection_custom_interval[TODAY-P2W]=Da oggi per due settimane
CustomAttributeSelection_custom_interval[TODAY-P1M]=Da oggi per un mese
CustomAttributeSelection_custom_interval[TODAY-P2M]=Da oggi per due mesi
CustomAttributes[]=custom_filter
CustomAttributeNames[custom_filter]=Per il secondo tab - filtra solo eventi
CustomAttributeTypes[custom_filter]=select
CustomAttributeSelection_custom_filter[]
CustomAttributeSelection_custom_filter[NULL]=Tutti gli eventi (nessun filtro)
CustomAttributeSelection_custom_filter[SPECIAL]=Eventi speciali
CustomAttributeSelection_custom_filter[MANIFESTAZIONE]=Eventi di tipo manifestazione
CustomAttributeSelection_custom_filter[MANIFESTAZIONE+SPECIAL]=Eventi speciali di tipo manifestazione
ViewList[]
ViewList[]=eventi_normal
ViewList[]=eventi_carousel
ViewList[]=eventi_wide
ViewName[eventi_normal]=Default
ViewName[eventi_carousel]=Carousel
ViewName[eventi_wide]=Wide
ItemsPerRow[]
ItemsPerRow[eventi_wide]=1

[GMapItems]
Name=Mappa
ManualAddingOfItems=disabled
CustomAttributes[]
CustomAttributes[]=parent_node_id
CustomAttributes[]=class
CustomAttributes[]=attribute
CustomAttributes[]=limit
CustomAttributes[]=width
CustomAttributes[]=height
UseBrowseMode[parent_node_id]=true
ViewList[]
ViewList[]=geo_located_content_osm
ViewList[]=map_nolist
ViewList[]=map_wide
ViewName[]
ViewName[geo_located_content_osm]=Mappa (OpenStreetMap)
ViewName[map_nolist]=Mappa senza lista (OpenStreetMap)
ViewName[map_wide]=Mappa wide (OpenStreetMap)
ItemsPerRow[]
ItemsPerRow[map_wide]=1

[AreaRiservata]
ManualAddingOfItems=disabled
CustomAttributes[]
CustomAttributes[]=parent_node_id
CustomAttributes[]=testo
CustomAttributes[]=signin
CustomAttributeTypes[testo]=text
CustomAttributeTypes[signin]=checkbox
UseBrowseMode[parent_node_id]=true
ViewList[]
ViewList[]=accesso_area_riservata
ViewName[]
ViewName[accesso_area_riservata]=Accesso area riservata

[HTML]
Name=Codice HTML
ManualAddingOfItems=disabled
CustomAttributes[]
CustomAttributes[]=html
CustomAttributeTypes[html]=text
ViewList[]
ViewList[]=html
ViewList[]=html_wide
ViewName[html]=html
ViewName[html_wide]=html wide
ItemsPerRow[]
ItemsPerRow[html_wide]=1

[Html3Colonne]
Name=Codice HTML in 3 colonne
ManualAddingOfItems=disabled
CustomAttributes[]
CustomAttributes[]=htmlCol1
CustomAttributes[]=htmlCol2
CustomAttributes[]=htmlCol3
CustomAttributeTypes[htmlCol1]=text
CustomAttributeTypes[htmlCol2]=text
CustomAttributeTypes[htmlCol3]=text
ViewList[]
ViewList[]=html_3_colonne
ViewName[html_3_colonne]=html



*/ ?>
