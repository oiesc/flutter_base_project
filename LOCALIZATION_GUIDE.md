# 🌍 Localization Organization Guide

This guide explains how translations are organized in the project by **sections/features** to facilitate maintenance and addition of new strings.

## 📁 **Organization Structure**

Translations are organized by **prefixes** that represent each section/feature:

### **1. 🏗️ APP CORE** - `app*`
Main application strings:
- `appTitle` - App title
- `appErrorInitializing` - Error during initialization
- `appTryAgain` - Try again
- `appVersion` - Version
- `appName` - App name

### **2. 🧭 NAVIGATION** - `nav*`
Navigation-related strings:
- `navHome` - Home
- `navSettings` - Settings  
- `navPageNotFound` - Page not found
- `navPageNotFoundMessage` - Error message with path
- `navGoHome` - Go to home

### **3. 🏠 HOME FEATURE** - `home*`
Home page strings:
- `homeWelcome` - Welcome message
- `homeFeatureTitle` - Feature list title
- `homeFeatureCleanArch` - Clean Architecture
- `homeFeatureStateManagement` - State management
- `homeFeatureI18n` - Internationalization
- `homeFeatureTheme` - Theme management
- `homeFeatureNavigation` - Navigation
- `homeFeatureStructure` - Project structure

### **4. ⚙️ SETTINGS FEATURE** - `settings*`
Settings page strings:
- `settingsTitle` - Page title
- `settingsThemeSection` - Theme section
- `settingsLanguageSection` - Language section
- `settingsAppInfoSection` - App info
- `settingsThemeLight/Dark/System` - Theme options
- `settingsLanguageEnglish/Portuguese` - Language options
- `settingsErrorLoading` - Error loading
- `settingsRetry` - Try again

## 📝 **How to Add New Translations**

### **Step 1: Identify the Feature**
Determine which feature/section the new string belongs to:
- App Core → `app*`
- Navigation → `nav*`  
- Home → `home*`
- Settings → `settings*`
- New Feature → `newFeature*`

### **Step 2: Add to ARB Files**

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

### **Step 3: Generate Translations**
```bash
flutter gen-l10n
```

### **Step 4: Use in Code**
```dart
Text(
  AppLocalizations.of(context)!.homeNewFeature ?? 'Fallback text',
)
```

## 🎯 **Naming Conventions**

### **Prefixes by Feature:**
- `app*` - Application core
- `nav*` - Navigation  
- `home*` - Home page
- `settings*` - Settings
- `auth*` - Authentication (future)
- `profile*` - Profile (future)

### **Suffixes by Type:**
- `*Title` - Titles
- `*Section` - Sections  
- `*Button` - Buttons
- `*Error` - Error messages
- `*Success` - Success messages
- `*Loading` - Loading states

### **Examples:**
```dart
// ✅ Good
"homeWelcomeTitle"
"settingsThemeSection" 
"authLoginButton"
"profileErrorLoading"

// ❌ Avoid
"welcome"
"theme"
"login"  
"error"
```

## 🔄 **Adding New Feature**

### **Example: Profile Feature**

**1. Add organized strings:**
```json
{
  "profileTitle": "Profile",
  "profileEditButton": "Edit Profile",
  "profileSaveButton": "Save Changes",
  "profileErrorSaving": "Error saving profile: {error}",
  "profileSuccessSaved": "Profile saved successfully"
}
```

**2. Use with consistent pattern:**
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
      // ...rest of the page
    );
  }
}
```

## 📊 **Organization Benefits**

| Aspect | Before | After |
|---------|-------|---------|
| **Location** | ❌ Scattered strings | ✅ Grouped by feature |
| **Maintenance** | ❌ Hard to find | ✅ Easy to locate and edit |
| **Collaboration** | ❌ Frequent conflicts | ✅ Each dev works on their feature |
| **Scalability** | ❌ Giant file | ✅ Clear organization |
| **Translation** | ❌ Lost context | ✅ Clear context by feature |

## 🚀 **Next Steps**

To add new features, follow this pattern:

1. **Define prefix** for the new feature
2. **Create section** in ARB files
3. **Document** the new strings
4. **Use consistently** in code
5. **Test** in both languages

This organization makes internationalization **simple, scalable and easy to maintain**! 🎯
