# AppTextUtils - Utilitário de Localização

O `AppTextUtils` é um utilitário criado para facilitar o acesso às strings localizadas do aplicativo, fornecendo uma interface mais limpa e com fallbacks automáticos.

## Como usar

### Método 1: Usando os métodos diretos (Recomendado)
```dart
// Em vez de:
AppLocalizations.of(context)!.appTitle ?? 'Flutter Base Project'

// Use:
AppTextUtils.appTitle(context)
```

### Método 2: Usando getString com seletor personalizado
```dart
// Para casos mais específicos:
AppTextUtils.getString(
  context, 
  (l10n) => l10n.appTitle, 
  'Fallback se não encontrar'
)
```

### Método 3: Acesso direto ao AppLocalizations
```dart
// Para acesso direto com null safety:
AppTextUtils.l10n(context)?.appTitle ?? 'Fallback'
```

## Métodos disponíveis

### Strings do aplicativo:
- `AppTextUtils.appTitle(context)` - Título do aplicativo
- `AppTextUtils.appErrorInitializing(context)` - Erro ao inicializar
- `AppTextUtils.appTryAgain(context)` - Tentar novamente
- `AppTextUtils.appVersion(context)` - Versão
- `AppTextUtils.appName(context)` - Nome do app

### Strings de navegação:
- `AppTextUtils.navHome(context)` - Início
- `AppTextUtils.navSettings(context)` - Configurações
- `AppTextUtils.navPageNotFound(context)` - Página não encontrada
- `AppTextUtils.navPageNotFoundMessage(context, path)` - Mensagem com caminho
- `AppTextUtils.navGoHome(context)` - Ir para início

## Exemplo prático

```dart
import '../l10n/app_text_utils.dart';

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Simples e limpo
        Text(AppTextUtils.appTitle(context)),
        
        // Com fallback personalizado
        Text(AppTextUtils.getString(
          context,
          (l10n) => l10n.appTitle,
          'Meu App'
        )),
        
        // Acesso direto para casos especiais
        if (AppTextUtils.l10n(context) != null)
          Text(AppTextUtils.l10n(context)!.appTitle),
      ],
    );
  }
}
```

## Vantagens

1. **Código mais limpo**: Menos código repetitivo
2. **Fallbacks automáticos**: Sempre tem um valor padrão
3. **Type safety**: Método tipado com null safety
4. **Fácil manutenção**: Centralizados em um local
5. **Flexibilidade**: Três formas diferentes de usar conforme a necessidade
