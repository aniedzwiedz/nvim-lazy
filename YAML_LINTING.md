# YAML Linting - Problemy i Rozwiązania

## ⚠️ Problem: Linter nie wykrywa "brakującego `:` "

### Przykład:
```yaml
---
packages:
  IGT-mod_security-log4shell-rule '1.1-1'
```

### Dlaczego linter nie zgłasza błędu?

**To jest POPRAWNY YAML!** 

Parser YAML interpretuje to jako:
```python
{
  'packages': "IGT-mod_security-log4shell-rule '1.1-1'"
}
```

Czyli `packages` zawiera **string**, nie dictionary/mapping.

---

## ✅ Rozwiązania

### 1. **Prawdopodobnie chciałeś dict/mapping:**

```yaml
---
packages:
  IGT-mod_security-log4shell-rule: '1.1-1'
  #                               ^ brakujące dwukropek!
```

To da:
```python
{
  'packages': {
    'IGT-mod_security-log4shell-rule': '1.1-1'
  }
}
```

### 2. **Lub listę dict (bardziej elastyczna struktura):**

```yaml
---
packages:
  - name: IGT-mod_security-log4shell-rule
    version: '1.1-1'
  - name: another-package
    version: '2.0-1'
```

To da:
```python
{
  'packages': [
    {'name': 'IGT-mod_security-log4shell-rule', 'version': '1.1-1'},
    {'name': 'another-package', 'version': '2.0-1'}
  ]
}
```

---

## 🔍 Jak sprawdzić co masz faktycznie w YAML?

### W Neovim:
```vim
" Otwórz plik YAML
:e test.yaml

" Sprawdź diagnostyki LSP
:lua vim.diagnostic.open_float()

" Lub uruchom linter ręcznie
<leader>l
```

### W terminalu:
```bash
# Sprawdź czy yamllint widzi błędy
yamllint twoj_plik.yaml

# Parser YAML (python)
python3 -c "import yaml; print(yaml.safe_load(open('twoj_plik.yaml')))"
```

---

## 🚀 Ulepszona Konfiguracja Lintingu

### Dodane automatyczne linting w czasie rzeczywistym

**Gdzie:** `lua/plugins/lint.lua`

**Co zmieniono:**
- Dodano linting na `BufEnter`, `InsertLeave`, `TextChanged`
- Debouncing (100ms) aby nie obciążać procesora
- Linting nadal działa na zapisie (`BufWritePost`)

**Rezultat:**
- Błędy YAML są teraz widoczne natychmiast (bez zapisu)
- Lepsza responsywność edytora

---

## 📋 Typowe Błędy YAML i Jak Je Wykryć

### 1. **Brak `:` po kluczu**
```yaml
packages
  my-package: '1.0'  # Błąd: 'packages' nie ma ':'
```
**Wykrycie:** yamllint **NIE WYKRYJE** - to poprawny YAML (packages to null)
**Rozwiązanie:** 
```yaml
packages:
  my-package: '1.0'
```

### 2. **Złe wcięcie**
```yaml
packages:
my-package: '1.0'  # Błąd: brak wcięcia
```
**Wykrycie:** yamllint **WYKRYJE** → `wrong indentation`

### 3. **Mieszane tab/spacje**
```yaml
packages:
	my-package: '1.0'  # Tab zamiast spacji
```
**Wykrycie:** yamllint **WYKRYJE** → `found character '\t' that cannot start any token`

### 4. **Niezamknięty string**
```yaml
packages:
  my-package: 'unclosed string
```
**Wykrycie:** yamllint **WYKRYJE** → `could not find expected`

### 5. **Niepoprawne znaki specjalne**
```yaml
packages:
  my-package: value with : inside  # ':' wymaga quotes
```
**Wykrycie:** yamllint **WYKRYJE** → `mapping values are not allowed here`
**Rozwiązanie:**
```yaml
packages:
  my-package: "value with : inside"
```

---

## 🛠️ Debugowanie Lintingu

### Sprawdź czy linter jest załadowany:
```vim
:lua print(vim.inspect(require('lint').linters_by_ft.yaml))
```
Powinno pokazać: `{ "yamllint" }`

### Sprawdź czy yamllint jest w PATH:
```vim
:!which yamllint
```
Powinno pokazać: `/home/.../.local/share/nvim-lazy/mason/bin/yamllint`

### Uruchom linter ręcznie:
```vim
<leader>l
```

### Zobacz wszystkie diagnostyki:
```vim
:lua vim.diagnostic.setqflist()
:copen
```

---

## 📝 Konfiguracja yamllint

**Plik:** `lua/plugins/yaml.lua`

**Obecna konfiguracja:**
- `line-length: max=120` - max 120 znaków
- `document-start: disable` - nie wymaga `---`
- `comments: min-spaces-from-content=0` - komentarze mogą być przy kodzie
- `indentation: spaces=consistent` - konsystentne wcięcia

**Dla Azure YAML:**
- yamllint jest **wyłączony** (condition returns false)
- Używa tylko LSP (azure-pipelines-language-server)

---

## 🎯 Najlepsze Praktyki

### 1. **Zawsze używaj `:` po kluczach**
```yaml
# ❌ Źle
packages
  my-package

# ✅ Dobrze
packages:
  my-package: value
```

### 2. **Konsystentne wcięcia (2 spacje)**
```yaml
# ✅ Dobrze
packages:
  first:
    nested: value
```

### 3. **Quote strings ze znakami specjalnymi**
```yaml
# ✅ Dobrze
version: "1.1-1"
name: "package-with-special:chars"
```

### 4. **Używaj schema validation (LSP)**
Dla plików jak `docker-compose.yml`, GitHub Actions, itp., LSP (yamlls) używa schema store aby walidować strukturę.

---

## ✅ Podsumowanie

**Twój przypadek:**
```yaml
IGT-mod_security-log4shell-rule '1.1-1'
```

**To jest poprawny YAML** (string jako wartość), dlatego yamllint nie wykrywa błędu.

**Prawdopodobnie chcesz:**
```yaml
IGT-mod_security-log4shell-rule: '1.1-1'
#                               ^ dodaj to!
```

**Lub:**
```yaml
packages:
  - name: IGT-mod_security-log4shell-rule
    version: '1.1-1'
```

**Dodatkowe ulepszen ia:**
- ✅ Dodano real-time linting (nie tylko przy zapisie)
- ✅ Debouncing aby nie obciążać CPU
- ✅ Manual trigger: `<leader>l`

---

*Last updated: 2026-06-03*
# YAML Formatting Update - yaml.azure Support

## ✅ Problem rozwiązany

### Issue:
Formatowanie nie działało dla `filetype=yaml.azure` bo:
1. `yamlfmt` nie był zainstalowany w Mason
2. Brak fallback formatera

### Solution:

**1. Dodano prettier jako fallback** (`lua/plugins/conform.lua` i `lua/plugins/yaml.lua`)
```lua
yaml = { 'yamlfmt', 'prettier', stop_after_first = true },
['yaml.azure'] = { 'yamlfmt', 'prettier', stop_after_first = true },
['yaml.ansible'] = { 'yamlfmt', 'prettier', stop_after_first = true },
['yaml.docker-compose'] = { 'yamlfmt', 'prettier', stop_after_first = true },
['yaml.gitlab'] = { 'yamlfmt', 'prettier', stop_after_first = true },
```

**Jak to działa:**
- `stop_after_first = true` - użyj pierwszego dostępnego formatera
- Jeśli `yamlfmt` jest zainstalowany → użyj yamlfmt (szybszy)
- Jeśli nie → użyj prettier (zawsze dostępny)

**2. Dodano konfigurację do yaml.lua**
Dzięki temu LazyVim wie że te filetypes potrzebują formatowania.

---

## 🚀 Jak używać

### Formatowanie manualne:
```vim
" Format current buffer
:Format

" Lub przez LSP
:lua vim.lsp.buf.format()

" Lub przez conform bezpośrednio
:ConformFormat
```

### Formatowanie automatyczne przy zapisie:
```lua
-- W options.lua zmień:
vim.g.autoformat = true

-- Lub per-buffer:
:lua vim.b.autoformat = true
```

### Sprawdź który formater jest używany:
```vim
:ConformInfo
```

---

## 📦 Instalacja yamlfmt (opcjonalnie)

yamlfmt jest szybszy niż prettier. Jeśli chcesz go używać:

```vim
:MasonInstall yamlfmt
```

Po instalacji Neovim automatycznie zacznie używać yamlfmt zamiast prettier.

---

## 🧪 Testowanie

**Test 1: Sprawdź dostępne formatery**
```vim
:lua print(vim.inspect(require('conform').list_formatters_for_ft('yaml.azure')))
```
Powinno pokazać: `{ "yamlfmt", "prettier" }`

**Test 2: Format Azure YAML**
```vim
" Stwórz test file
:e /tmp/test.yaml
:set ft=yaml.azure

" Wklej przykładowy YAML i sformatuj
:Format
```

**Test 3: Sprawdź który formater jest używany**
```vim
:ConformInfo
```

---

## 📊 Supported YAML filetypes

Formatowanie teraz działa dla wszystkich wariantów YAML:

| Filetype | Formater (kolejność) | Status |
|----------|---------------------|--------|
| `yaml` | yamlfmt → prettier | ✅ |
| `yaml.azure` | yamlfmt → prettier | ✅ |
| `yaml.ansible` | yamlfmt → prettier | ✅ |
| `yaml.docker-compose` | yamlfmt → prettier | ✅ |
| `yaml.gitlab` | yamlfmt → prettier | ✅ |

---

## ⚙️ Konfiguracja prettier dla YAML

Prettier używa następujących domyślnych ustawień dla YAML:
- Indentation: 2 spacje
- Quote style: preferowane double quotes dla stringów ze spacjami
- Trailing commas: none (YAML nie obsługuje)
- Line length: 80 (można zmienić w `.prettierrc`)

**Dostosowanie prettier:**
Stwórz `.prettierrc` w głównym katalogu projektu:
```json
{
  "tabWidth": 2,
  "proseWrap": "preserve",
  "printWidth": 120
}
```

---

## 🎯 Najlepsze Praktyki

### 1. **Używaj LSP + Formatter razem**
- LSP (yamlls) - walidacja struktury i schemy
- Formatter (yamlfmt/prettier) - konsystentne formatowanie

### 2. **Per-project settings**
```yaml
# .prettierrc.yaml
tabWidth: 2
printWidth: 120
proseWrap: preserve
```

### 3. **Azure Pipelines specific**
Dla Azure Pipelines YAML, LSP (azure_pipelines_ls) zapewnia:
- Walidację zadań i poleceń
- Autocomplete dla Azure-specific syntax
- Schema validation

---

## 📝 Zmienione pliki

1. `lua/plugins/conform.lua` - Dodano prettier fallback dla wszystkich YAML filetypes
2. `lua/plugins/yaml.lua` - Dodano sekcję formatowania z conform.nvim
3. Dokumentacja zaktualizowana

---

*Updated: 2026-06-03*
