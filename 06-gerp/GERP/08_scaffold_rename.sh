#!/bin/bash
#SBATCH --account=rrg-shaferab
#SBATCH --job-name=scaffold_rename
#SBATCH --mem 12G
#SBATCH --output=%x-%j.out
#SBATCH --time=0-12:00
#SBATCH --mail-user=ericwootton@trentu.ca
#SBATCH --mail-type=ALL

sed -i "1s/>.*/>Alces_alces/" alces_alces_filtered_scaffolds/*.fa
sed -i "1s/>.*/>Antilocapra_americana/" antilocapra_americana_filtered_scaffolds/*.fa
sed -i "1s/>.*/>Bos_taurus/" bos_taurus_filtered_scaffolds/*.fa
sed -i "1s/>.*/>Camelus_bactrianus/" camelus_bactrianus_filtered_scaffolds/*.fa
sed -i "1s/>.*/>Camelus_dromedarius/" camelus_dromedarius_filtered_scaffolds/*.fa
sed -i "1s/>.*/>Ceratotherium_simum/" ceratotherium_simum_filtered_scaffolds/*.fa
sed -i "1s/>.*/>Cervus_elaphus/" cervus_elaphus_filtered_scaffolds/*.fa
sed -i "1s/>.*/>Connochaetes_taurinus/" connochaetes_taurinus_filtered_scaffolds/*.fa
sed -i "1s/>.*/>Diceros_bicornis/" diceros_bicornis_filtered_scaffolds/*.fa
sed -i "1s/>.*/>Equus_asinus/" equus_asinus_filtered_scaffolds/*.fa
sed -i "1s/>.*/>Equus_caballus/" equus_caballus_filtered_scaffolds/*.fa
sed -i "1s/>.*/>Giraffa_camelopardalis/" giraffa_camelopardalis_filtered_scaffolds/*.fa
sed -i "1s/>.*/>Hippopotamus_amphibius/" hippopotamus_amphibius_filtered_scaffolds/*.fa
sed -i "1s/>.*/>Moschus_chrysogaster/" moschus_chrysogaster_filtered_scaffolds/*.fa
sed -i "1s/>.*/>Moschus_moschiferus/" moschus_moschiferus_filtered_scaffolds/*.fa
sed -i "1s/>.*/>Ovis_canadensis/" ovis_canadensis_filtered_scaffolds/*.fa
sed -i "1s/>.*/>Phacochoerus_africanus/" phacochoerus_africanus_filtered_scaffolds/*.fa
sed -i "1s/>.*/>Sus_scrofa/" sus_scrofa_filtered_scaffolds/*.fa
sed -i "1s/>.*/>Tapirus_terrestris/" tapirus_terrestris_filtered_scaffolds/*.fa
sed -i "1s/>.*/>Tragulus_javanicus/" tragulus_javanicus_filtered_scaffolds/*.fa
