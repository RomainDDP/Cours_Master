#pragma once
#include <string>

enum class TypeMessage {
    NOUVELLE_PIECE,
    PREPARER_MACHINE,
    DEPOSER_PIECE,
    RETIRER_PIECE,
    FIN_USINAGE,
    CONVOYEUR_LIBRE,
    COMPTE_RENDU,
    AUTRE
};

struct Message {
    TypeMessage type;
    int idEmetteur;
    int idRecepteur;
	std::string contenu;
};

