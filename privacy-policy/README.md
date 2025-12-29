# Privacy Policy - URL Player

This directory contains the privacy policy pages for the URL Player app, ready to be deployed to GitHub Pages.

## Files

- `index.html` - Arabic version (default)
- `privacy-policy-en.html` - English version

## Features

- ✅ Professional, modern design
- ✅ Responsive (mobile-friendly)
- ✅ Bilingual (Arabic & English)
- ✅ Language toggle button
- ✅ Clean, easy-to-read layout
- ✅ Gradient background
- ✅ Contact information included

## How to Deploy to GitHub Pages

### Option 1: Using GitHub Web Interface

1. Go to your GitHub repository
2. Click "Add file" → "Upload files"
3. Drag and drop both HTML files
4. Commit the changes
5. Go to Settings → Pages
6. Select branch: `main` (or `master`)
7. Select folder: `/privacy-policy`
8. Click Save
9. Your privacy policy will be available at: `https://yourusername.github.io/quan_play/privacy-policy/`

### Option 2: Using Git Command Line

```bash
# Navigate to your project
cd e:\projects\quan_play

# Add files to git
git add privacy-policy/

# Commit
git commit -m "Add privacy policy pages"

# Push to GitHub
git push origin main
```

Then enable GitHub Pages in repository settings.

### Option 3: Create a Separate Repository

1. Create a new repository named `url-player-privacy`
2. Upload the HTML files
3. Enable GitHub Pages
4. URL will be: `https://yourusername.github.io/url-player-privacy/`

## Customization

Before deploying, update the following in both HTML files:

1. **Email Address:** Change `support@urlplayer.app` to your actual email
2. **Website:** Change `urlplayer.app` to your actual website (or remove if you don't have one)
3. **Last Updated Date:** Already set to December 29, 2025

## Privacy Policy URL for Play Console

Once deployed, use the full URL in Google Play Console:

- Example: `https://yourusername.github.io/quan_play/privacy-policy/`
- Or: `https://yourusername.github.io/url-player-privacy/`

## Testing

Before deploying, you can test locally by:

1. Opening `index.html` in your browser
2. Clicking the language toggle to test both versions
3. Checking all links work correctly

## Notes

- The privacy policy is comprehensive and covers all Google Play requirements
- It clearly states that no personal data is collected
- It explains local data storage using ObjectBox
- It includes contact information for user inquiries
- Both Arabic and English versions are identical in content
