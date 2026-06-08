import 'package:flutter/material.dart';

/// Sistema de dimensiones centralizado para la UI.
///
/// Organizado en grupos semánticos para facilitar la búsqueda y mantener
/// consistencia visual a lo largo de la aplicación.
///
/// Guía de uso rápido:
/// - Espaciado entre elementos  → [AppSpacing]
/// - Tamaños de íconos          → [AppIcon]
/// - Tamaños de componentes     → [AppComponent]
/// - Radios de esquinas         → [AppShape]
/// - Bordes y divisores         → [AppStroke]
/// - Imágenes y multimedia      → [AppMedia]
/// - Sombras / elevación        → [AppElevation]
/// - Posicionamiento (offsets)  → [AppOffset]

// ─────────────────────────────────────────────────────────────────────────────
// SPACING  —  Grid de 4dp
// Usar en: padding, margin, SizedBox, gap entre ítems de fila/columna.
// ─────────────────────────────────────────────────────────────────────────────
abstract final class AppSpacing {
  static const double xxs = 2;
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 20;
  static const double xxl = 24;
  static const double xxxl = 28;
  static const double none = 0;
}

// ─────────────────────────────────────────────────────────────────────────────
// ICON SIZES
// Usar en: SvgPicture.asset(width: …), Icon(size: …), SizedBox.
// ─────────────────────────────────────────────────────────────────────────────
abstract final class AppIcon {
  // — Dots & indicators ───────────────────────────────────────────────────────
  static const double metaDot = 3;
  static const double dot = 10;

  // — Escala general (menor → mayor) ─────────────────────────────────────────
  static const double xxs = 16;
  static const double xs = 24;
  static const double sm = 32;
  static const double md = 44;
  static const double lg = 56;
  static const double xl = 72;

  // — Ilustraciones semánticas ────────────────────────────────────────────────
  static const double close = 30;
  static const double update = 70;
  static const double circular = 70;
  static const double warning = 80;
  static const double star = 100;
  static const double logo = 140;
  static const double launcher = 270;
}

// ─────────────────────────────────────────────────────────────────────────────
// ELEVATION
// Usar en: Card(elevation: …), Material(elevation: …), BoxShadow.
// ─────────────────────────────────────────────────────────────────────────────
abstract final class AppElevation {
  static const double none = 0;
  static const double card = 3;
  static const double snackbar = 8;
  static const double dropdown = 15;
}

// ─────────────────────────────────────────────────────────────────────────────
// COMPONENT SIZES
// Medidas fijas de componentes reutilizables.
// ─────────────────────────────────────────────────────────────────────────────
abstract final class AppComponent {
  // — Zero sizes (used to collapse/hide components programmatically) ──────────
  static const double noneWidth = 0;
  static const double noneHeight = 0;

  // — Buttons ─────────────────────────────────────────────────────────────────
  static const double buttonHeight = 50;
  static const double cardActionButtonHeight = 40;
  static const double buttonCornerRadius = 30;
  static const double topBarActionWidth = 40;
  static const double topBarActionHeight = 48;

  // — Fields ──────────────────────────────────────────────────────────────────
  static const double fieldHeight = 56;

  // — Cards ───────────────────────────────────────────────────────────────────
  static const double cardHeight = 100;
  static const double cardOptionHeight = 50;
  static const double collectionCardHeight = 140;
  static const double sectionCardHeight = 80;

  // — Tabs & indicators ───────────────────────────────────────────────────────
  static const double tabIndicatorHeight = 5;

  // — Navigation drawer ───────────────────────────────────────────────────────
  static const double drawerWidth = 270;

  // — Dropdowns & autocomplete ────────────────────────────────────────────────
  static const double dropdownWidth = 350;
  static const double dropdownHeight = 250;
  static const double dropdownMaxHeight = 200;
  static const double autoCompleteWidth = 280;
  static const double autoCompleteMaxHeight = 150;

  // — Rewards ─────────────────────────────────────────────────────────────────
  static const double rewardsItemHeight = 16;
  static const double rewardsPointsHeight = 24;

  // — Misc ────────────────────────────────────────────────────────────────────
  static const double pagerMinHeight = 400;
  static const double headerHeight = 150;
  static const double codeRowHeight = 90;
  static const double gridCellMinSize = 55;
  static const double directionButtonPadding = 48;
  static const double actionCardHeight = 150;
  static const double collectionBadgeMaxWidth = 90;

  // — Heatmap ─────────────────────────────────────────────────────────────────
  static const double heatmapGap = 3;
  static const double heatmapCellRadiusSticker = 3;
  static const double heatmapCellRadiusCard = 2;
  static const double rangeBarWidth = 3;
  static const double rangeBarHeight = 32;

  // — Top App Bar ─────────────────────────────────────────────────────────────
  static const double largeTopBarExpandedHeight = 96;
}

// ─────────────────────────────────────────────────────────────────────────────
// MEDIA  —  Imágenes y recursos visuales
// ─────────────────────────────────────────────────────────────────────────────
abstract final class AppMedia {
  static const double imagePreviewSize = 180;
  static const double collectionImageWidth = 100;
  static const double uploadedPhotoHeight = 130;
  static const double preGuideHeaderHeight = 100;
  static const double avatarSize = 96;
  static const double profilePhotoSize = 80;
}

// ─────────────────────────────────────────────────────────────────────────────
// STROKE & BORDER
// Usar en: Divider(thickness: …), Border, Canvas drawLine.
// ─────────────────────────────────────────────────────────────────────────────
abstract final class AppStroke {
  static const double thin = 0.5;
  static const double divider = 1;
  static const double figure = 2;
  static const double upload = 3;
  static const double circular = 6;
}

// ─────────────────────────────────────────────────────────────────────────────
// SHAPE  —  Radios de esquinas
// Usar en: RoundedRectangleBorder, BorderRadius.circular(…), ClipRRect.
// ─────────────────────────────────────────────────────────────────────────────
abstract final class AppShape {
  static const double none = 0;
  static const double field = 8;
  static const double dialog = 10;
  static const double rounded = 12;
  static const double badge = 99;
}

// ─────────────────────────────────────────────────────────────────────────────
// OFFSET  —  Desplazamientos y posicionamiento absoluto
// Usar en: Transform.translate, Positioned dentro de Stack.
// ─────────────────────────────────────────────────────────────────────────────
abstract final class AppOffset {
  static const Offset badge = Offset(4, -4);
  static const Offset tab = Offset(0, -3);
  static const Offset photo = Offset(0, -10);
  static const Offset progress = Offset(0, -80);
}
