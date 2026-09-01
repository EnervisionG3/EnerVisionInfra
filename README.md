# EnerVision — Infrastructure

Code Terraform provisionnant les ressources Azure du projet EnerVision.

## Contexte

Architecture hybride : l'application s'exécute en conteneurs sur le serveur
on-premise de l'école. Seuls le stockage objet et la gestion des identités
sont hébergés sur Azure.

Ressources gérées par ce dépôt :

| Ressource | Usage | Ticket |
|---|---|---|
| Storage Account | données brutes capteurs, artefacts MLflow | INFRA-10 |
| Container Registry | images Docker du projet | INFRA-05 |
| Role assignments | permissions selon le moindre privilège | INFRA-06 |

Le resource group `rg-AHamon2023_cours-projet-eadl` est fourni par l'école.
Il n'est pas créé par ce code mais référencé via un data source : aucun droit
n'est accordé au niveau de la souscription.

## Prérequis

- [Terraform](https://developer.hashicorp.com/terraform/install) >= 1.9
- [Azure CLI](https://learn.microsoft.com/cli/azure/install-azure-cli)
- Un compte Azure avec le rôle `Devops-cours-projet-eadl` sur le resource group

Vérification :

```bash
terraform -version
az version
```

## Authentification

Terraform utilise les identifiants de la session Azure CLI.

```bash
az login
az account show
```

Si plusieurs souscriptions sont disponibles :

```bash
az account set --subscription "<nom-ou-id>"
```

## Utilisation

```bash
# Initialiser (télécharge les providers)
terraform init

# Prévisualiser les changements
terraform plan

# Appliquer
terraform apply
```

## Structure

```
.
├── provider.tf     # providers azurerm et azuread, versions épinglées
├── main.tf         # data source du resource group
├── variables.tf    # variables d'entrée
└── .gitignore
```

## Variables

| Variable | Description | Défaut |
|---|---|---|
| `resource_group_name` | Resource group cible | `rg-AHamon2023_cours-projet-eadl` |

Chaque apprenant dispose de son propre resource group. Pour réutiliser ce code,
surcharger la variable :

```bash
terraform plan -var="resource_group_name=rg-<VOTRE-COMPTE>_cours-projet-eadl"
```

## Fichiers versionnés

`.terraform.lock.hcl` **doit** être committé : il garantit que toute l'équipe
utilise les mêmes versions de providers.

Ne jamais committer : `*.tfstate`, `*.tfvars`, `.terraform/`. Le fichier d'état
contient des valeurs sensibles en clair.

## État Terraform

L'état est actuellement stocké localement. La migration vers un backend distant
(Azure Storage) est traitée dans INFRA-10, qui crée le compte de stockage requis.

## Documentation

La documentation d'architecture et les décisions techniques sont sur Confluence.
Ce README couvre uniquement l'utilisation du dépôt.