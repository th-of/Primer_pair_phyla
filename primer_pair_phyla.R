library(microcontax)
library(microseq)

data(contax.trim)
contax.trim$ReverseComp <- reverseComplement(contax.trim$Sequence)

PCR.forward.primer <- iupac2regex("CCTACGGGRBGCASCAG")
PCR.reverse.primer <- iupac2regex("GGACTACYVGGGTATCTAAT")

matched_forward <- grepl(PCR.forward.primer, contax.trim$Sequence)
matched_reverse <- grepl(PCR.reverse.primer, contax.trim$ReverseComp)

matched_phyla <- c()
unmatched_phyla <- c()

# For use with grepl

for (i in 1:length(matched_forward)){
  if (matched_forward[i] == TRUE & matched_reverse[i] == TRUE) {
    matched_phyla <- append(matched_phyla, getPhylum(contax.trim$Header[i]))
  }
  else {
    unmatched_phyla <- append(unmatched_phyla, getPhylum(contax.trim$Header[i]))
  }
}

unmatched_phyla <- unique(unmatched_phyla)

sprintf("Phyla not matched with both primers: %s", unmatched_phyla)

# for (x in 1:length(contax.trim)){
#   if (x %in% c(matched_forward & matched_reverse)){
#     matched_phyla <- append(matched_phyla, getPhylum(contax.trim$Header[x]))
#   }
#     else {
#       unmatched_phyla <- append(unmatched_phyla, getPhylum(contax.trim$Header[x]))
#   }
# }

# n = 0
# matched_phyla <- c()
# unmatched_genera <- c()
# for (x in matched_forward){
#   if (x %in% matched_reverse){
#     n = n+1
#     matched_phyla <- append(matched_phyla, getPhylum(contax.trim$Header[x]))
#   }
# }
# matched_phyla <- unique(matched_phyla)
# 
# sprintf("Phyla matched to both primers: %s", matched_phyla)
# sprintf("Number of sequences not matched to both primers: %i", length(contax.trim$Sequence)-n )