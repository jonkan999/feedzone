// Color palette configuration for Feed Zone
// This can be easily swapped out for different retro bicycling themes

export const colorPalette = {
  // Default retro bicycling palette (can be replaced later)
  primary: '#2C5F2D',      // Forest green
  secondary: '#97BC62',    // Light green
  accent: '#FF6B35',       // Orange accent
  background: '#F5F5DC',   // Beige/cream background
  surface: '#FFFFFF',      // White surface
  text: '#1A1A1A',         // Dark text
  'text-muted': '#666666', // Muted text
};

// CSS variables string for injection into styles
export const colorVariables = `
  --color-primary: ${colorPalette.primary};
  --color-secondary: ${colorPalette.secondary};
  --color-accent: ${colorPalette.accent};
  --color-background: ${colorPalette.background};
  --color-surface: ${colorPalette.surface};
  --color-text: ${colorPalette.text};
  --color-text-muted: ${colorPalette['text-muted']};
`;

