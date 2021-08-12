# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
if AdminUser.count == 0
    AdminUser.create!(email: 'admin@abilitiz.com', password: 'password', password_confirmation: 'password') if Rails.env.development?
    
    Utilisateur.create!([
        {
            nom: 'Zhang',
            prenom: 'Junxi',
            email: 'junxizhang@efficom-lille.fr',
            roleNo: 0,
            password: 'password',
            password_confirmation: 'password',
            dateDeNaissance: '1990/02/06',
            telephone: '0600000000'
        },
        {
            nom: 'Baillieul',
            prenom: 'Etienne',
            email: 'etienne@baillieul.fr',
            roleNo: 1,
            password: 'password',
            password_confirmation: 'password',
            dateDeNaissance: '1994/05/06',
            telephone: '0600000000',
            niveauExperience: '5 ans',
            passion1: 'Football', 
            passion2: 'Informatique', 
            passion3: 'Cyclisme'
        },
        {
            nom: 'Dor',
            prenom: 'Lionel',
            email: 'dorLionel@efficom-lille.fr',
            roleNo: 1,
            password: 'password',
            password_confirmation: 'password',
            dateDeNaissance: '1998/07/01',
            telephone: '0600000000',
            niveauExperience: '4 ans',
            passion1: 'Informatique', 
            passion2: 'Voley', 
            passion3: 'Sécurité'
        },
        {
            nom: 'Debels',
            prenom: 'Marvin',
            email: 'debelsMarvin@efficom-lille.fr', 
            roleNo: 1,
            password: 'password',
            password_confirmation: 'password',
            dateDeNaissance: '1999/08/15',
            telephone: '0600000000',
            niveauExperience: '2 ans',
            passion1: 'Blague', 
            passion2: 'Jeux vidéos', 
            passion3: 'Cigarette'
        }
    ])

    Parcour.create!([
        {
            metier: 'Developpeur Web',
            secteur: 'Banque',
            experience: '2 ans',
            utilisateur_id: 2
        },
        {
            metier: 'Analyste ',
            secteur: 'Supermarché',
            experience: '6 mois',
            utilisateur_id: 3
        },
        {
            metier: 'Analyste Integrateur',
            secteur: 'Assurance',
            experience: '1 an',
            utilisateur_id: 4
        },
        {
            metier: 'Developpeur Integrateur', 
            secteur: 'SSII', 
            experience: '1 an',
            utilisateur_id: 4
        }
    ])

    Jeu.create!([
        {
            nomJeu: 'Quizz', 
            lienJeu: '/quizz'
        },
        {
            nomJeu: 'QCM',
            lienJeu: '/qcm'
        },
        {
            nomJeu: '2048',
            lienJeu: '/2048'
        }
    ])

    CategorieSoftSkill.create!([
        {
            nomCategorie: 'Agilité sociale'
        },
        {
            nomCategorie: 'Agilité cognitive'
        },
        {
            nomCategorie: 'Personnalité'
        }
    ])
    
    SoftSkill.create!([
        {
            nomSoftSkill: 'Définition',
            categorie_soft_skill_id: 1
        },
        {
            nomSoftSkill: 'Logique',
            categorie_soft_skill_id: 1
        },
        {
            nomSoftSkill: 'Sémantique',
            categorie_soft_skill_id: 1
        },
        {
            nomSoftSkill: 'Mémoire',
            categorie_soft_skill_id: 1
        },
        {
            nomSoftSkill: 'Leadership',
            categorie_soft_skill_id: 2
        },
        {
            nomSoftSkill: 'Gestion du stress',
            categorie_soft_skill_id: 2
        },
        {
            nomSoftSkill: 'Esprit d’équipe',
            categorie_soft_skill_id: 2
        },
        {
            nomSoftSkill: 'Organisation',
            categorie_soft_skill_id: 2
        },
        {
            nomSoftSkill: 'Initiative',
            categorie_soft_skill_id: 2
        },
        {
            nomSoftSkill: 'Extraversion / Introversion',
            categorie_soft_skill_id: 3
        },
        {
            nomSoftSkill: 'Apprentissage',
            categorie_soft_skill_id: 3
        },
        {
            nomSoftSkill: 'Communication',
            categorie_soft_skill_id: 3
        }
    ])

    EquipeSoftSkill.create!([
        {
            nomEquipe: 'Developpeur Full Stack',
            niveauImportance: 0,
            soft_skill_id: 1
        },
        {
            nomEquipe: 'Developpeur Bankend',
            niveauImportance: 2,
            soft_skill_id: 3
        },
        {
            nomEquipe: 'Developpeur Frontend',
            niveauImportance: 3,
            soft_skill_id: 2
        }
    ])
    
    Equipe.create!([
        {
            recruteur_id: 1,
            candidat_id: 2,
            equipe_soft_skill_id: 1
        },
        {
            recruteur_id: 1,
            candidat_id: 3,
            equipe_soft_skill_id: 1
        },
        {
            recruteur_id: 1,
            candidat_id: 4,
            equipe_soft_skill_id: 2
        }
    ])

    SoftSkillJeu.create!([
        {
            soft_skill_id: 1,
            jeu_id: 1
        },
        {
            soft_skill_id: 2,
            jeu_id: 2
        },
        {
            soft_skill_id: 1,
            jeu_id: 3
        }
    ])
    
    Score.create!([
        {
            resultat: 100,
            utilisateur_id: 2,
            soft_skill_jeu_id: 1
        },
        {
            resultat: 0,
            utilisateur_id: 2,
            soft_skill_jeu_id: 2
        }
    ])
end
