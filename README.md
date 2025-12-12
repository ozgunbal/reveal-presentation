# React Native to Flutter Presentation

A reveal.js presentation about migrating from React Native to Flutter.

## Development

Run the presentation locally:

```bash
npm start
```

This will start a local server at http://localhost:8000

## Building for slides.com

To create a bundled zip file ready for upload to slides.com:

```bash
npm run build
```

Or run the build script directly:

```bash
./build.sh
```

This will:
- Clean previous build files
- Create a `build/` directory with all necessary assets
- Copy reveal.js, fonts, and images
- Update file paths in index.html for bundled version
- Create `presentation-bundle.zip` ready for upload

## Image Optimization

Images have been optimized to reduce bundle size. If you add new images and want to optimize them:

```bash
./optimize-images.sh
```

This will:
- Resize large images to max 1200px width
- Convert PNG to JPEG (quality 85) for better compression
- Backup originals to `images_backup/`
- Save ~13MB of space (79% reduction)

## Output

After building, you'll get:
- `build/` - Directory containing the unbundled presentation (~11MB)
- `presentation-bundle.zip` - Zip file ready for slides.com upload (~7.4MB)

## Structure

```
.
├── index.html              # Main presentation file
├── images/                 # Presentation images
├── node_modules/           # Dependencies (reveal.js, fonts)
├── build.sh               # Build script
├── package.json           # Project configuration
└── presentation-bundle.zip # Generated zip file (after build)
```

## Dependencies

- reveal.js 5.2.1
- @fontsource/ubuntu 5.2.8

## GitHub Pages Deployment

This presentation is automatically deployed to GitHub Pages via GitHub Actions.

### Live URL

Once deployed, the presentation will be available at:
`https://YOUR-USERNAME.github.io/YOUR-REPO-NAME/`

### Deployment Process

The presentation is automatically built and deployed when changes are pushed to the `main` branch:

1. Push changes to `main` branch
2. GitHub Actions workflow triggers automatically
3. Dependencies are installed (`npm ci`)
4. Build script runs (`bash build.sh`)
5. Built files are deployed to GitHub Pages
6. Site updates in 1-2 minutes

### Manual Deployment Trigger

To manually trigger a deployment:

1. Go to the "Actions" tab in your GitHub repository
2. Select "Deploy to GitHub Pages" workflow
3. Click "Run workflow" button
4. Select the `main` branch
5. Click "Run workflow"

### Local Testing Before Deployment

Always test locally before pushing:

```bash
# Run local server
npm start

# Build and verify
npm run build

# Check build output
ls -lh build/
```

### Making Updates

1. Edit files locally (e.g., `index.html`)
2. Test locally: `npm start`
3. Commit and push:
   ```bash
   git add <modified-files>
   git commit -m "Description of changes"
   git push origin main
   ```
4. Deployment happens automatically

### Troubleshooting

**Workflow fails:**
- Check the "Actions" tab for error logs
- Verify all dependencies are in `package.json`
- Test build locally: `bash build.sh`
- Ensure `build/` directory is properly generated

**404 error on live site:**
- Verify Settings → Pages shows "GitHub Actions" source
- Wait 2-5 minutes after deployment completes
- Check that `build/` directory has `index.html` at root

**Blank page (assets not loading):**
- Verify all paths in `index.html` are relative (no leading `/`)
- Check `build/index.html` was created correctly by `build.sh`
