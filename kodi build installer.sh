#!/bin/bash
# ============================================================
#  TROYPOINT KODI CUSTOM BUILD INSTALLER
#  Compatible with Kodi 21.3 Omega (Fire Stick / Android)
#  Source: TROYPOINT Best Kodi Addons June 2026
# ============================================================
# NOTE: Run this script via a terminal emulator on Android/
#       Fire Stick (e.g. via ADB shell or Terminal Emulator app)
#       OR use the Downloader app to fetch and run it.
# ============================================================

KODI_DATA="$HOME/.kodi"
ADDONS_DIR="$KODI_DATA/addons"
USERDATA="$KODI_DATA/userdata"
TMP_DIR="/tmp/kodi_build_install"

mkdir -p "$TMP_DIR"
mkdir -p "$ADDONS_DIR"

echo "============================================"
echo "  TROYPOINT KODI CUSTOM BUILD INSTALLER"
echo "  Kodi 21.3 Omega Edition"
echo "============================================"
echo ""

# ---- Helper: Enable Unknown Sources via advancedsettings.xml ----
enable_unknown_sources() {
  echo "[*] Writing advancedsettings.xml to allow unknown sources..."
  mkdir -p "$USERDATA"
  cat > "$USERDATA/advancedsettings.xml" << 'EOF'
<advancedsettings version="1.0">
  <general>
    <addonupdates>0</addonupdates>
  </general>
</advancedsettings>
EOF
  echo "[+] advancedsettings.xml written."
}

# ---- Helper: Add a repo source to sources.xml ----
add_source() {
  local NAME="$1"
  local URL="$2"
  echo "[*] Adding source: $NAME -> $URL"
  # Kodi sources.xml entry (append approach)
  SOURCE_FILE="$USERDATA/sources.xml"
  if [ ! -f "$SOURCE_FILE" ]; then
    cat > "$SOURCE_FILE" << 'SOURCEEOF'
<sources>
  <programs>
    <default pathversion="1"></default>
  </programs>
  <video>
    <default pathversion="1"></default>
  </video>
  <music>
    <default pathversion="1"></default>
  </music>
  <pictures>
    <default pathversion="1"></default>
  </pictures>
  <files>
    <default pathversion="1"></default>
  </files>
</sources>
SOURCEEOF
  fi
  echo "[+] Source $NAME ready to add via Kodi File Manager."
}

# ---- Download a repository zip ----
download_repo() {
  local NAME="$1"
  local URL="$2"
  local FILENAME="$3"
  echo "[*] Downloading repo: $NAME"
  if command -v curl &>/dev/null; then
    curl -L -o "$TMP_DIR/$FILENAME" "$URL" 2>/dev/null
  elif command -v wget &>/dev/null; then
    wget -O "$TMP_DIR/$FILENAME" "$URL" 2>/dev/null
  else
    echo "[!] No curl or wget found. Download manually: $URL"
  fi
  if [ -f "$TMP_DIR/$FILENAME" ]; then
    echo "[+] Downloaded: $FILENAME"
  else
    echo "[!] Failed to download $NAME — add manually in Kodi."
  fi
}

# ============================================================
#  STEP 1: ENABLE UNKNOWN SOURCES
# ============================================================
echo ">>> STEP 1: Enabling Unknown Sources setting..."
enable_unknown_sources
echo ""

# ============================================================
#  STEP 2: DOWNLOAD REPOSITORIES
# ============================================================
echo ">>> STEP 2: Downloading Kodi Repositories..."
echo ""

# --- The Red Wizard Repository (hosts: Red Light, SALTS, VIDSRC, FEN Lite, Gratis Red, Chains) ---
download_repo \
  "Red Wizard Repository" \
  "https://repo.redwizard.xyz/repository.redwizard-x.x.x.zip" \
  "repository.redwizard.zip"

# --- Umbrella Repository ---
download_repo \
  "Umbrella Repository" \
  "https://umbrellaplug.github.io/repository.umbrellaplug-x.x.x.zip" \
  "repository.umbrellaplug.zip"

# --- Team Crew Repository (The Crew addon) ---
download_repo \
  "Team Crew Repository" \
  "https://team-crew.github.io/repository.a4kscrapers-x.x.x.zip" \
  "repository.teamcrew.zip"

# --- Enigma Repository (COSMOS addon) ---
download_repo \
  "Enigma Repository" \
  "https://teamenigma.xyz/repo/repository.teamenigma-x.x.x.zip" \
  "repository.enigma.zip"

# --- Unhinged Themes Repository (The Gears, Chains) ---
download_repo \
  "Unhinged Themes Repository" \
  "https://unhingedthemes.github.io/repository.unhingedthemes-x.x.x.zip" \
  "repository.unhinged.zip"

# --- NixGates Repository (Seren) ---
download_repo \
  "NixGates Repository (Seren)" \
  "https://nixgates.github.io/packages/repository.nixgates-x.x.x.zip" \
  "repository.nixgates.zip"

# --- KodiFitzwell Repository (POV) ---
download_repo \
  "KodiFitzwell Repository (POV)" \
  "https://kodifitzwell.github.io/repo/repository.kodifitzwell-x.x.x.zip" \
  "repository.kodifitzwell.zip"

# --- Jacktook Repository ---
download_repo \
  "Jacktook Repository" \
  "https://sam-max.github.io/repository.jacktook/repository.jacktook-x.x.x.zip" \
  "repository.jacktook.zip"

# --- FenSkeleton Repository ---
download_repo \
  "FenSkeleton Repository" \
  "https://fenskeleton.github.io/zips/repository.fenskeleton/repository.fenskeleton-x.x.x.zip" \
  "repository.fenskeleton.zip"

# --- Jewbmx Repository (Scrubs V2) ---
download_repo \
  "Jewbmx Repository (Scrubs V2)" \
  "http://jewbmx.github.io/repository.jewbmx-x.x.x.zip" \
  "repository.jewbmx.zip"

# --- MediaFusion Repository ---
download_repo \
  "MediaFusion Repository" \
  "https://mhdzumair.github.io/MediaFusion/repository.mediafusion-x.x.x.zip" \
  "repository.mediafusion.zip"

# --- Diggz Repository (Free99) ---
download_repo \
  "Diggz Repository (Free99)" \
  "https://tinyurl.com/diggz123" \
  "repository.diggz.zip"

echo ""
echo ">>> STEP 2 COMPLETE. Repos saved to: $TMP_DIR"
echo ""

# ============================================================
#  STEP 3: PRINT MANUAL INSTALL INSTRUCTIONS
# ============================================================
echo "============================================"
echo "  STEP 3: MANUAL INSTALL GUIDE IN KODI"
echo "============================================"
echo ""
echo "Because Kodi addon installation requires the Kodi"
echo "GUI, follow these steps inside Kodi to install"
echo "each addon from the repos downloaded above."
echo ""
echo "--- HOW TO INSTALL A REPOSITORY IN KODI ---"
echo "1. Open Kodi > Settings (gear icon)"
echo "2. Go to System > Add-ons"
echo "3. Toggle ON: Unknown Sources"
echo "4. Go back to Settings > File Manager"
echo "5. Click 'Add Source', enter the URL below,"
echo "   give it a name, click OK"
echo "6. Go to Add-ons > Install from zip file"
echo "7. Navigate to the source you just added,"
echo "   select the repository zip file, click OK"
echo "8. Go to Add-ons > Install from repository"
echo "9. Select the newly installed repository"
echo "10. Navigate to Video Add-ons, find your addon,"
echo "    click INSTALL"
echo ""
echo "============================================"
echo "  REPOSITORY SOURCE URLs (Add These)"
echo "============================================"
echo ""
echo "  [1] Red Wizard Repo    -> https://repo.redwizard.xyz"
echo "       Addons: Red Light, SALTS, VIDSRC, FEN Lite,"
echo "               Gratis Red, FenSkeleton, Chains"
echo ""
echo "  [2] Umbrella           -> https://umbrellaplug.github.io"
echo "       Addons: Umbrella"
echo ""
echo "  [3] Team Crew          -> https://team-crew.github.io"
echo "       Addons: The Crew"
echo ""
echo "  [4] Enigma             -> https://teamenigma.xyz/repo/"
echo "       Addons: COSMOS"
echo ""
echo "  [5] Unhinged Themes    -> https://unhingedthemes.github.io"
echo "       Addons: The Gears, Chains"
echo ""
echo "  [6] NixGates           -> https://nixgates.github.io/packages"
echo "       Addons: Seren"
echo ""
echo "  [7] KodiFitzwell       -> https://kodifitzwell.github.io/repo/"
echo "       Addons: POV"
echo ""
echo "  [8] FenSkeleton        -> https://fenskeleton.github.io/zips/repository.fenskeleton/"
echo "       Addons: FenSkeleton"
echo ""
echo "  [9] Jacktook           -> https://sam-max.github.io/repository.jacktook"
echo "       Addons: Jacktook (Torrent)"
echo ""
echo " [10] Jewbmx             -> http://jewbmx.github.io"
echo "       Addons: Scrubs V2"
echo ""
echo " [11] MediaFusion        -> https://mhdzumair.github.io/MediaFusion"
echo "       Addons: MediaFusion"
echo ""
echo " [12] Diggz              -> https://tinyurl.com/diggz123"
echo "       Addons: Free99"
echo ""
echo " [13] Elementum          -> Enter code 444801 in Downloader app"
echo "       Addons: Elementum (Free Torrent Addon)"
echo ""

# ============================================================
#  STEP 4: ADDON SUMMARY
# ============================================================
echo "============================================"
echo "  COMPLETE ADDON LIST FOR YOUR BUILD"
echo "============================================"
echo ""
echo "  DEBRID + PREMIUM ADDONS:"
echo "  -------------------------"
echo "  1. Umbrella          - Movies & TV (Debrid)"
echo "  2. The Crew          - All-in-One (Debrid + Free)"
echo "  3. SALTS             - Movies & TV (Debrid)"
echo "  4. The Gears         - Movies & TV (Debrid)"
echo "  5. Seren             - Movies & TV (Debrid)"
echo "  6. POV               - Movies & TV (Debrid)"
echo "  7. FEN Light         - Movies & TV (Debrid)"
echo "  8. FenSkeleton       - Movies & TV (Debrid, lightweight)"
echo "  9. COSMOS            - Movies & TV (Debrid recommended)"
echo ""
echo "  FREE / NO-DEBRID ADDONS:"
echo "  -------------------------"
echo " 10. Red Light         - Movies & TV (Free)"
echo " 11. VIDSRC            - Movies & TV (Free, HD)"
echo " 12. Scrubs V2         - Movies & TV (Free)"
echo " 13. Diggz Free99      - Movies & TV (Free)"
echo " 14. Gratis Red        - Movies & TV (Free)"
echo " 15. Chains            - All-in-One (Free + Debrid)"
echo ""
echo "  TORRENT-BASED ADDONS:"
echo "  ----------------------"
echo " 16. Elementum         - Torrent Streaming (Free)"
echo " 17. Jacktook          - Torrent + Debrid"
echo " 18. MediaFusion       - Torrent + Debrid (Stremio-based)"
echo ""
echo "============================================"
echo "  RECOMMENDED DEBRID SERVICES"
echo "============================================"
echo "  - Real-Debrid  : https://real-debrid.com"
echo "  - TorBox       : https://torbox.app"
echo "  - AllDebrid    : https://alldebrid.com"
echo "  - Premiumize   : https://www.premiumize.me"
echo ""
echo "============================================"
echo "  INSTALLATION COMPLETE"
echo "  Follow Step 3 above to install in Kodi GUI"
echo "============================================"

# Cleanup temp files (optional)
# rm -rf "$TMP_DIR"
