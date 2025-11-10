# Setup Guide - Dotfiles Installation & Synchronisation

Komplette Anleitung zur Installation und Synchronisation Ihrer yabai/skhd Dotfiles auf neuen und bestehenden Macs.

---

## 📦 Installation auf einem neuen Mac

### Schritt 1: Repository klonen

```bash
git clone https://github.com/ChronicT98/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

### Schritt 2: Installation ausführen

```bash
./install.sh
```

Das Script installiert automatisch:
- ✅ Homebrew (falls nicht vorhanden)
- ✅ yabai (Window Manager)
- ✅ skhd (Hotkey Daemon)
- ✅ Erstellt Symlinks zu den Configs
- ✅ Startet die Services

### Schritt 3: Berechtigungen erteilen

Nach der Installation müssen Sie Berechtigungen erteilen:

1. **System Settings → Privacy & Security → Accessibility**
   - ✅ yabai aktivieren
   - ✅ skhd aktivieren

2. **System Settings → Privacy & Security → Screen Recording**
   - ✅ yabai aktivieren (für Animationen)

3. **Mac neu starten** (empfohlen)

### Schritt 4: Optional - SIP teilweise deaktivieren

Für erweiterte Features (Fenster zwischen Spaces verschieben, Opacity, etc.):

1. Mac in Recovery Mode starten (⌘ + R beim Start)
2. Terminal öffnen
3. Ausführen:
```bash
csrutil enable --without fs --without debug --without nvram
```
4. Neu starten

Mehr Infos: https://github.com/koekeishiya/yabai/wiki/Disabling-System-Integrity-Protection

---

## 🔄 Configs aktualisieren (bestehender Mac)

### Methode 1: Update-Script (Empfohlen)

```bash
cd ~/dotfiles
./update.sh
```

Das Script:
- Pullt neueste Änderungen von GitHub
- Startet yabai und skhd neu

### Methode 2: Manuell

```bash
cd ~/dotfiles
git pull
yabai --restart-service
skhd --restart-service
```

---

## 🚀 Änderungen zu GitHub pushen

### Einmalige Einrichtung - GitHub CLI installieren

```bash
brew install gh
gh auth login
```

Wählen Sie:
- **HTTPS** als Protokoll
- **Login with a web browser**
- Folgen Sie den Anweisungen im Browser

Nach dem Login:
```bash
gh auth setup-git
```

### Änderungen pushen

#### 1. Configs lokal ändern

Bearbeiten Sie die Dateien direkt:
```bash
# Mit einem Editor Ihrer Wahl:
nano ~/dotfiles/.config/yabai/yabairc
nano ~/dotfiles/.config/skhd/skhdrc

# Oder mit VS Code:
code ~/dotfiles
```

#### 2. Änderungen testen

```bash
yabai --restart-service
skhd --restart-service

# Oder mit Shortcut: ctrl + alt + cmd + r
```

#### 3. Zu Git committen und pushen

```bash
cd ~/dotfiles
git add -A
git commit -m "Beschreibung Ihrer Änderungen"
git push
```

**Beispiele für Commit-Messages:**
```bash
git commit -m "Add new shortcuts for window positioning"
git commit -m "Update animation speed to 0.3s"
git commit -m "Add Chrome to unmanaged apps"
```

---

## 🔀 Änderungen von mehreren PCs synchronisieren

### Szenario: Sie haben auf beiden PCs Änderungen gemacht

#### Auf PC 1 (wo Sie gerade arbeiten):

```bash
cd ~/dotfiles
git add -A
git commit -m "Änderungen von PC 1"
git push
```

#### Auf PC 2 (mit lokalen Änderungen):

```bash
cd ~/dotfiles

# 1. Lokale Änderungen committen
git add -A
git commit -m "Änderungen von PC 2"

# 2. Änderungen von GitHub holen UND kombinieren
git pull --rebase

# 3. Kombinierte Änderungen pushen
git push

# 4. Services neu starten
yabai --restart-service
skhd --restart-service
```

**Was macht `--rebase`?**
- Holt Änderungen von GitHub
- Setzt Ihre lokalen Änderungen darauf
- Vermeidet unnötige Merge-Commits
- Hält die Git-Historie sauber

### Bei Merge-Konflikten

Falls Git meldet: "CONFLICT (content): Merge conflict in ..."

```bash
# 1. Konflikt-Dateien manuell bearbeiten
nano ~/dotfiles/.config/skhd/skhdrc

# 2. Konflikt-Marker entfernen (<<<<<<, ======, >>>>>>)

# 3. Weiter mit Rebase
git add -A
git rebase --continue

# 4. Pushen
git push
```

---

## 🛠️ Nützliche Git-Befehle

### Status prüfen

```bash
cd ~/dotfiles
git status
```

Zeigt:
- Welche Dateien geändert wurden
- Ob Sie Commits haben, die noch nicht gepusht sind
- Ob Ihr lokaler Stand mit GitHub übereinstimmt

### Änderungen anzeigen

```bash
# Welche Zeilen wurden geändert?
git diff

# Was wurde im letzten Commit gemacht?
git log -1 -p
```

### Letzte Commits anzeigen

```bash
git log --oneline -5
```

### Lokale Änderungen verwerfen

```bash
# ACHTUNG: Löscht alle lokalen Änderungen!
git stash

# Änderungen wiederherstellen:
git stash pop
```

### Zu vorheriger Version zurück

```bash
# Alle lokalen Änderungen verwerfen und GitHub-Stand holen
git reset --hard origin/main
git pull
```

---

## 🔧 Häufige Probleme & Lösungen

### Problem: "Permission denied" beim Push

**Lösung:**
```bash
gh auth setup-git
git push
```

### Problem: Shortcuts funktionieren nicht nach Update

**Lösung:**
```bash
skhd --restart-service

# Falls das nicht hilft:
skhd --stop-service
skhd --start-service
```

### Problem: Symlinks sind kaputt

```bash
# Prüfen:
ls -la ~/.config/yabai/yabairc
ls -la ~/.config/skhd/skhdrc

# Falls keine Symlinks (kein ->), neu erstellen:
rm ~/.config/yabai/yabairc
rm ~/.config/skhd/skhdrc
ln -s ~/dotfiles/.config/yabai/yabairc ~/.config/yabai/yabairc
ln -s ~/dotfiles/.config/skhd/skhdrc ~/.config/skhd/skhdrc
```

### Problem: yabai lädt Config nicht

```bash
# Prüfen ob yabairc ausführbar ist:
chmod +x ~/dotfiles/.config/yabai/yabairc

# Service neu starten:
yabai --restart-service
```

### Problem: "could not locate config file"

```bash
# Symlink fehlt - neu erstellen:
ln -s ~/dotfiles/.config/yabai/yabairc ~/.config/yabai/yabairc
ln -s ~/dotfiles/.config/skhd/skhdrc ~/.config/skhd/skhdrc
yabai --restart-service
skhd --restart-service
```

---

## 📝 App-Namen für Rules herausfinden

Um Apps zu yabai Rules hinzuzufügen:

```bash
# App öffnen und fokussieren, dann:
yabai -m query --windows --window | jq '.app'

# Oder alle laufenden Apps anzeigen:
yabai -m query --windows | jq -r '.[].app' | sort -u
```

Dann in `~/dotfiles/.config/yabai/yabairc` hinzufügen:
```bash
yabai -m rule --add app="^App Name$" manage=off
```

---

## 🎯 Workflow-Zusammenfassung

### Tägliche Nutzung

```bash
# Morgens auf PC 1:
cd ~/dotfiles && ./update.sh

# Änderungen machen, testen, pushen:
git add -A && git commit -m "Update" && git push

# Abends auf PC 2:
cd ~/dotfiles && ./update.sh
```

### Bei lokalen Änderungen auf beiden PCs

```bash
# Auf PC mit lokalen Änderungen:
cd ~/dotfiles
git add -A
git commit -m "Lokale Änderungen"
git pull --rebase
git push
```

---

## 📚 Weiterführende Links

- [yabai Dokumentation](https://github.com/koekeishiya/yabai)
- [skhd Dokumentation](https://github.com/koekeishiya/skhd)
- [yabai Wiki](https://github.com/koekeishiya/yabai/wiki)
- [GitHub CLI Dokumentation](https://cli.github.com/manual/)

---

## 💡 Tipps

1. **Regelmäßig pushen**: Committen und pushen Sie Änderungen häufig
2. **Beschreibende Commits**: Nutzen Sie aussagekräftige Commit-Messages
3. **Vor großen Änderungen**: Machen Sie `git pull` um Konflikte zu vermeiden
4. **Testen vor dem Push**: Stellen Sie sicher, dass Configs funktionieren
5. **Backups**: Die `.backup` Dateien können Sie nach erfolgreichen Tests löschen

---

**Repository:** https://github.com/ChronicT98/dotfiles
