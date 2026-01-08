// CDN Configuration
// This file helps manage image URLs for both local development and CDN production

const CDN_BASE_URL = import.meta.env.PUBLIC_CDN_BASE_URL || '';
const USE_CDN = import.meta.env.PUBLIC_USE_CDN === 'true';

/**
 * Get the full URL for an image, using CDN if configured
 * @param imagePath - Relative path from public directory (e.g., '/images/products/...')
 * @returns Full URL to the image
 */
export function getImageUrl(imagePath: string): string {
  if (!imagePath) return '/images/placeholder.jpg';
  
  // If CDN is enabled and base URL is set, use CDN
  if (USE_CDN && CDN_BASE_URL) {
    // Remove leading slash if present, CDN base URL should handle it
    const cleanPath = imagePath.startsWith('/') ? imagePath.slice(1) : imagePath;
    return `${CDN_BASE_URL}/${cleanPath}`;
  }
  
  // Otherwise use local path
  return imagePath;
}

/**
 * Get multiple image URLs
 * @param imagePaths - Array of relative image paths
 * @returns Array of full URLs
 */
export function getImageUrls(imagePaths: string[]): string[] {
  return imagePaths.map(path => getImageUrl(path));
}

/**
 * Check if CDN is enabled
 */
export function isCdnEnabled(): boolean {
  return USE_CDN && !!CDN_BASE_URL;
}

