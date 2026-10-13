# octacore

## Dependencies

### Mutagen

You need to create a config file at `~/.config/matugen/config.toml`

```toml
[templates.quickshell]
input_path = '~/.config/matugen/templates/colors_quickshell.json'
output_path = '~/.cache/matugen/colors_quickshell.json'
```

You need to create a template at `~/.config/matugen/templates/colors_quickshell.json`

```toml
{
  "primary": "{{colors.primary.default.hex}}",
  "primaryOn": "{{colors.on_primary.default.hex}}",
  "primaryContainer": "{{colors.primary_container.default.hex}}",
  "primaryContainerOn": "{{colors.on_primary_container.default.hex}}",
  "primaryFixed": "{{colors.primary_fixed.default.hex}}",
  "primaryFixedDim": "{{colors.primary_fixed_dim.default.hex}}",
  "primaryFixedOn": "{{colors.on_primary_fixed.default.hex}}",
  "primaryFixedVariantOn": "{{colors.on_primary_fixed_variant.default.hex}}",
  "inversePrimary": "{{colors.inverse_primary.default.hex}}",

  "secondary": "{{colors.secondary.default.hex}}",
  "secondaryOn": "{{colors.on_secondary.default.hex}}",
  "secondaryContainer": "{{colors.secondary_container.default.hex}}",
  "secondaryContainerOn": "{{colors.on_secondary_container.default.hex}}",
  "secondaryFixed": "{{colors.secondary_fixed.default.hex}}",
  "secondaryFixedDim": "{{colors.secondary_fixed_dim.default.hex}}",
  "secondaryFixedOn": "{{colors.on_secondary_fixed.default.hex}}",
  "secondaryFixedVariantOn": "{{colors.on_secondary_fixed_variant.default.hex}}",

  "tertiary": "{{colors.tertiary.default.hex}}",
  "tertiaryOn": "{{colors.on_tertiary.default.hex}}",
  "tertiaryContainer": "{{colors.tertiary_container.default.hex}}",
  "tertiaryContainerOn": "{{colors.on_tertiary_container.default.hex}}",
  "tertiaryFixed": "{{colors.tertiary_fixed.default.hex}}",
  "tertiaryFixedDim": "{{colors.tertiary_fixed_dim.default.hex}}",
  "tertiaryFixedOn": "{{colors.on_tertiary_fixed.default.hex}}",
  "tertiaryFixedVariantOn": "{{colors.on_tertiary_fixed_variant.default.hex}}",

  "error": "{{colors.error.default.hex}}",
  "errorOn": "{{colors.on_error.default.hex}}",
  "errorContainer": "{{colors.error_container.default.hex}}",
  "errorContainerOn": "{{colors.on_error_container.default.hex}}",

  "background": "{{colors.background.default.hex}}",
  "backgroundOn": "{{colors.on_background.default.hex}}",

  "surface": "{{colors.surface.default.hex}}",
  "surfaceOn": "{{colors.on_surface.default.hex}}",
  "surfaceVariant": "{{colors.surface_variant.default.hex}}",
  "surfaceVariantOn": "{{colors.on_surface_variant.default.hex}}",
  "surfaceDim": "{{colors.surface_dim.default.hex}}",
  "surfaceBright": "{{colors.surface_bright.default.hex}}",
  "surfaceContainerLowest": "{{colors.surface_container_lowest.default.hex}}",
  "surfaceContainerLow": "{{colors.surface_container_low.default.hex}}",
  "surfaceContainer": "{{colors.surface_container.default.hex}}",
  "surfaceContainerHigh": "{{colors.surface_container_high.default.hex}}",
  "surfaceContainerHighest": "{{colors.surface_container_highest.default.hex}}",
  "inverseSurface": "{{colors.inverse_surface.default.hex}}",
  "inverseOnSurface": "{{colors.inverse_on_surface.default.hex}}",

  "outline": "{{colors.outline.default.hex}}",
  "outlineVariant": "{{colors.outline_variant.default.hex}}",
  "shadow": "{{colors.shadow.default.hex}}",
  "scrim": "{{colors.scrim.default.hex}}",
  "surfaceTint": "{{colors.surface_tint.default.hex}}",
  "sourceColor": "{{colors.source_color.default.hex}}"
}
```