# 🌍 Localization Organization Guide

Este guia explica como as traduções estão organizadas no projeto por **seções/features** para facilitar manutenção e adição de novas strings.

## 📁 **Estrutura de Organização**

As traduções estão organizadas por **prefixos** que representam cada seção/feature:

### **1. 🏗️ APP CORE** - `app*`
Strings principais da aplicação:
- `appTitle` - Título do app
- `appErrorInitializing` - Erro ao inicializar
- `appTryAgain` - Tentar novamente
- `appVersion` - Versão
- `appName` - Nome do app

### **2. 🧭 NAVIGATION** - `nav*`
Strings relacionadas à navegação:
- `navHome` - Início
- `navSettings` - Configurações  
- `navPageNotFound` - Página não encontrada
- `navPageNotFoundMessage` - Mensagem de erro com path
- `navGoHome` - Ir para início

### **3. 🏠 HOME FEATURE** - `home*`
Strings da página inicial:
- `homeWelcome` - Mensagem de boas-vindas
- `homeFeatureTitle` - Título da lista de features
- `homeFeatureCleanArch` - Clean Architecture
- `homeFeatureStateManagement` - Gerenciamento de estado
- `homeFeatureI18n` - Internacionalização
- `homeFeatureTheme` - Gerenciamento de tema
- `homeFeatureNavigation` - Navegação
- `homeFeatureStructure` - Estrutura do projeto

### **4. ⚙️ SETTINGS FEATURE** - `settings*`
Strings da página de configurações:
- `settingsTitle` - Título da página
- `settingsThemeSection` - Seção de tema
- `settingsLanguageSection` - Seção de idioma
- `settingsAppInfoSection` - Informações do app
- `settingsThemeLight/Dark/System` - Opções de tema
- `settingsLanguageEnglish/Portuguese` - Opções de idioma
- `settingsErrorLoading` - Erro ao carregar
- `settingsRetry` - Tentar novamente

## 📝 **Como Adicionar Novas Traduções**

### **Passo 1: Identificar a Feature**
Determine a qual feature/seção a nova string pertence:
- App Core → `app*`
- Navigation → `nav*`  
- Home → `home*`
- Settings → `settings*`
- Nova Feature → `novaFeature*`

### **Passo 2: Adicionar nos Arquivos ARB**

**`lib/global/l10n/app_en.arb`:**
```json
{
  "homeNewFeature": "New amazing feature",
  "@homeNewFeature": {
    "description": "Description of the new feature"
  }
}
```

**`lib/global/l10n/app_pt.arb`:**
```json
{
  "homeNewFeature": "Nova funcionalidade incrível"
}
```

### **Passo 3: Gerar Traduções**
```bash
flutter gen-l10n
```

### **Passo 4: Usar no Código**
```dart
Text(
  AppLocalizations.of(context)!.homeNewFeature ?? 'Fallback text',
)
```

## 🎯 **Convenções de Nomenclatura**

### **Prefixos por Feature:**
- `app*` - Core da aplicação
- `nav*` - Navegação  
- `home*` - Página inicial
- `settings*` - Configurações
- `auth*` - Autenticação (futuro)
- `profile*` - Perfil (futuro)

### **Sufixos por Tipo:**
- `*Title` - Títulos
- `*Section` - Seções  
- `*Button` - Botões
- `*Error` - Mensagens de erro
- `*Success` - Mensagens de sucesso
- `*Loading` - Estados de carregamento

### **Exemplos:**
```dart
// ✅ Bom
"homeWelcomeTitle"
"settingsThemeSection" 
"authLoginButton"
"profileErrorLoading"

// ❌ Evitar
"welcome"
"theme"
"login"  
"error"
```

## 🔄 **Adicionando Nova Feature**

### **Exemplo: Feature de Perfil**

**1. Adicionar strings organizadas:**
```json
{
  "profileTitle": "Profile",
  "profileEditButton": "Edit Profile",
  "profileSaveButton": "Save Changes",
  "profileErrorSaving": "Error saving profile: {error}",
  "profileSuccessSaved": "Profile saved successfully"
}
```

**2. Usar com padrão consistente:**
```dart
class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.profileTitle ?? 'Profile',
        ),
      ),
      // ...resto da página
    );
  }
}
```

## 📊 **Benefícios da Organização**

| Aspecto | Antes | Depois |
|---------|-------|---------|
| **Localização** | ❌ Strings espalhadas | ✅ Agrupadas por feature |
| **Manutenção** | ❌ Difícil encontrar | ✅ Fácil localizar e editar |
| **Colaboração** | ❌ Conflitos frequentes | ✅ Cada dev trabalha em sua feature |
| **Escalabilidade** | ❌ Arquivo gigante | ✅ Organização clara |
| **Tradução** | ❌ Contexto perdido | ✅ Contexto claro por feature |

## 🚀 **Próximos Passos**

Para adicionar novas features, siga este padrão:

1. **Definir prefixo** da nova feature
2. **Criar seção** nos arquivos ARB
3. **Documentar** as novas strings
4. **Usar consistentemente** no código
5. **Testar** em ambos os idiomas

Esta organização torna a internacionalização **simples, escalável e fácil de manter**! 🎯
