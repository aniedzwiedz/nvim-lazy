# Lualine Enhancement - Formatters Display

## ✅ Zaktualizowano Lualine

### Zmiany w `lua/plugins/user.lua`

Lualine teraz wyświetla **pełną informację o narzędziach** używanych w bieżącym buforze:

```lua
-- PRZED (tylko LSP + Linters)
LSP: yamlls | Lint: yamllint

-- PO (LSP + Formatters + Linters)
LSP: yamlls | Fmt: prettier | Lint: yamllint
```

---

## 🎨 Przykłady Wyświetlania

### Python File
```
LSP: pyright | Fmt: ruff | Lint: ruff
```

### TypeScript File
```
LSP: vtsls | Fmt: biome | Lint: biome
```

### YAML Azure File
```
LSP: azure_pipelines_ls, yamlls | Fmt: prettier | Lint: yamllint
```

### Go File
```
LSP: gopls | Fmt: goimports, gofumpt | Lint: golangci-lint
```

### Markdown File
```
LSP: marksman | Fmt: prettier, markdownlint-cli2 | Lint: markdownlint-cli2
```

### Shell Script
```
LSP: bash-language-server | Fmt: shfmt | Lint: shellcheck
```

---

## 🔍 Co Jest Wyświetlane

### 1. **LSP** (Language Server Protocol)
- Serwery językowe dołączone do bufora
- Zapewniają: autocomplete, go-to-definition, diagnostics
- Przykład: `pyright`, `vtsls`, `gopls`

### 2. **Fmt** (Formatters) - **NOWE!**
- **Tylko dostępne** formatery (zainstalowane i gotowe)
- Lista w kolejności użycia (pierwszy dostępny jest używany)
- Przykład: `prettier`, `ruff`, `biome`

### 3. **Lint** (Linters)
- Skonfigurowane lintery dla tego typu pliku
- Mogą nie być dostępne jeśli nie zainstalowane
- Przykład: `yamllint`, `ruff`, `shellcheck`

---

## 🚀 Jak To Działa

### Kod w lualine:

```lua
-- Get active formatters for current buffer
local conform_ok, conform = pcall(require, 'conform')
if conform_ok then
  local ft = vim.bo.filetype
  local available_formatters = conform.list_formatters_for_ft(ft)
  for _, formatter in ipairs(available_formatters) do
    if formatter.available then  -- ← Tylko dostępne!
      table.insert(formatters, formatter.name)
    end
  end
end
```

**Kluczowa różnica:**
- `formatter.available` → sprawdza czy formater jest **zainstalowany**
- Jeśli yamlfmt nie jest zainstalowany, pokazuje `prettier` (fallback)
- Jeśli yamlfmt jest zainstalowany, pokazuje `yamlfmt`

---

## 📊 Diagnostyka przez Lualine

### Gdy widzisz "Fmt: prettier" dla YAML
Oznacza to:
- ✅ prettier jest zainstalowany i będzie użyty
- ℹ️ yamlfmt nie jest zainstalowany (fallback aktywny)
- 💡 Możesz zainstalować yamlfmt: `:MasonInstall yamlfmt`

### Gdy widzisz "Fmt: yamlfmt" dla YAML
Oznacza to:
- ✅ yamlfmt jest zainstalowany i będzie użyty (szybszy!)
- ✅ prettier jest dostępny jako fallback (gdyby yamlfmt był usunięty)

### Brak "Fmt: ..."
Oznacza to:
- ❌ Brak dostępnych formaterów dla tego typu pliku
- 🔧 Sprawdź `:ConformInfo` dla szczegółów

---

## 🧪 Testowanie

### Test 1: Otwórz plik YAML
```vim
:e test.yaml
```
**Oczekiwany output w lualine:**
```
LSP: yamlls | Fmt: prettier | Lint: yamllint
```

### Test 2: Otwórz plik Python
```vim
:e test.py
```
**Oczekiwany output w lualine:**
```
LSP: pyright | Fmt: ruff | Lint: ruff
```

### Test 3: Otwórz plik TypeScript
```vim
:e test.ts
```
**Oczekiwany output w lualine:**
```
LSP: vtsls | Fmt: biome | Lint: biome
```

### Test 4: Zainstaluj yamlfmt i sprawdź zmianę
```vim
:MasonInstall yamlfmt
:e test.yaml
```
**Oczekiwany output w lualine:**
```
LSP: yamlls | Fmt: yamlfmt | Lint: yamllint
```

---

## 🎯 Korzyści

### 1. **Natychmiastowa Widoczność**
- Od razu wiesz jakie narzędzia są aktywne
- Nie musisz uruchamiać `:ConformInfo` lub `:LspInfo`

### 2. **Debug Formatowania**
- Widzisz który formater będzie użyty przy `:Format`
- Łatwo sprawdzić czy fallback jest aktywny

### 3. **Potwierdzenie Instalacji**
- Po zainstalowaniu yamlfmt/biome/ruff, od razu widać zmianę
- Natychmiastowa feedback loop

### 4. **Kompletny Obraz**
- Jedna linijka pokazuje cały tooling stack
- LSP + Formatter + Linter w jednym miejscu

---

## ⚙️ Konfiguracja

### Lokalizacja w Lualine
Informacja jest w `lualine_x` (prawa strona statusline)

### Kolor
Domyślnie: `#808080` (szary, aby nie dominował)

### Kolejność wyświetlania
```
LSP → Formatters → Linters
```

### Zmiana koloru (opcjonalnie)
```lua
-- W lua/plugins/user.lua, zmień:
color = { fg = '#808080' },  -- szary
-- na np.:
color = { fg = '#6CB6FF' },  -- niebieski
```

---

## 📝 Format Wyjścia

### Separator
```
LSP: ... | Fmt: ... | Lint: ...
      ↑         ↑         ↑
   " | " jako separator między sekcjami
```

### Wielokrotne narzędzia
```
Fmt: goimports, gofumpt
     ↑
  ", " jako separator w ramach sekcji
```

### Brak narzędzi
- Jeśli brak LSP/Formatters/Linters → sekcja nie jest wyświetlana
- Pustych separatorów `|` nie ma

---

## 🔧 Troubleshooting

### "Nie widzę Fmt: ... w lualine"
**Możliwe przyczyny:**
1. Lualine jeszcze się nie załadował - poczekaj chwilę
2. Brak formaterów dla tego filetype - sprawdź `:ConformInfo`
3. Błąd w konfiguracji - sprawdź `:messages`

**Rozwiązanie:**
```vim
" Restart Neovim
:qa
nvim

" Lub reload config
:source ~/.config/nvim-lazy/init.lua
```

### "Fmt pokazuje niewłaściwy formater"
**Możliwe przyczyny:**
1. Filetype jest inny niż myślisz - sprawdź `:set ft?`
2. Formater jest skonfigurowany ale nie działa - sprawdź `:ConformInfo`

**Rozwiązanie:**
```vim
" Sprawdź dokładny filetype
:lua print(vim.bo.filetype)

" Sprawdź dostępne formatery
:lua print(vim.inspect(require('conform').list_formatters_for_ft(vim.bo.filetype)))
```

### "Fmt pokazuje tylko jeden formater gdy mam kilka"
To jest **poprawne zachowanie**!
- `stop_after_first = true` w konfiguracji
- Pokazuje tylko **dostępne** formatery
- Pierwszy dostępny jest używany, reszta to fallbacki

---

## 📚 Powiązane Dokumentacje

- **ConformInfo** - `:ConformInfo` - szczegółowe info o formaterach
- **LspInfo** - `:LspInfo` - szczegółowe info o LSP
- **[FORMATTER_LINTER_UPDATES.md](./FORMATTER_LINTER_UPDATES.md)** - Pełna konfiguracja formaterów

---

*Updated: 2026-06-03*
