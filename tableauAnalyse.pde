import java.util.*;
class tableauAnalyse{
  //linked hashmap pour preserver l'ordre d'affichage
  LinkedHashMap <symbole,ArrayList<ArrayList<symbole>>> tabAnalyse;
  
  
  tableauAnalyse(){
    tabAnalyse = new LinkedHashMap <symbole,ArrayList<ArrayList<symbole>>>(10);
  }
  
  void ajouterRegle(symbole s){
    tabAnalyse.put(s,new ArrayList<ArrayList<symbole>>());
  }
  
  void ajouter_tab_symb_term(symbole s){
    tabAnalyse.get(s).add(new ArrayList<symbole>());
  }
  
  void ajouter_symb_term(symbole s, int numero_regle,symbole sT){
    tabAnalyse.get(sT).get(numero_regle).add(s);
  }
  
  void afficherHash(){
    for(Map.Entry<symbole,ArrayList<ArrayList<symbole>>> entry : tabAnalyse.entrySet()){
      print("Regle : " + entry.getKey().nom); 
        print(" || Symboles liés : ");
      for(int i = 0; i<entry.getValue().size(); i++){
        for(int j = 0; j<entry.getValue().get(i).size();j++){
          print(entry.getValue().get(i).get(j).nom + " ");
        }
        println();
      }
      
  }
}
}
