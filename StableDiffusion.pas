unit StableDiffusion;

interface

uses
  Winapi.Windows, System.SysUtils;

const
  rng_type_to_str: array[0..1] of string = (
    'std_default',
    'cuda'
  );

  // Names of the sampler method, same order as enum sample_method in stable-diffusion.h
  sample_method_str: array[0..9] of string = (
    'euler_a',
    'euler',
    'heun',
    'dpm2',
    'dpm++2s_a',
    'dpm++2m',
    'dpm++2mv2',
    'ipndm',
    'ipndm_v',
    'lcm'
  );

  // Names of the sigma schedule overrides, same order as sample_schedule in stable-diffusion.h
  schedule_str: array[0..5] of string = (
    'default',
    'discrete',
    'karras',
    'exponential',
    'ays',
    'gits'
  );

  modes_str: array[0..3] of string = (
    'txt2img',
    'img2img',
    'img2vid',
    'convert'
  );


type
  TSDMode = (
    SMTXT2IMG,
    SMIMG2IMG,
    SMIMG2VID,
    SMCONVERT,
    SMMODE_COUNT
  );

  TRngType = (
    Standard,
    Cuda
  );

  TSampler = (
    Euler_A,
    Euler,
    Heun,
    DPM2,
    DPMPP2SA,
    DPMPP2M,
    DPMPP2Mv2,
    IPNDM,
    IPNDM_V,
    LCM
  );

  TSchedule = (
    Default,
    Discrete,
    Karras,
    Exponential,
    AYS,
    GITS
  );

  TQuantization = (
    F32 = 0,
    F16 = 1,
    Q4_0 = 2,
    Q4_1 = 3,
    Q5_0 = 6,
    Q5_1 = 7,
    Q8_0 = 8,
    Q8_1 = 9,
    Q2_K = 10,
    Q3_K = 11,
    Q4_K = 12,
    Q5_K = 13,
    Q6_K = 14,
    Q8_K = 15,
    IQ2_XXS = 16,
    IQ2_XS = 17,
    IQ3_XXS = 18,
    IQ1_S = 19,
    IQ4_NL = 20,
    IQ3_S = 21,
    IQ2_S = 22,
    IQ4_XS = 23,
    I8 = 24,
    I16 = 25,
    I32 = 26,
    I64 = 27,
    F64 = 28,
    IQ1_M = 29,
    BF16 = 30,
    Q4_0_4_4 = 31,
    Q4_0_4_8 = 32,
    Q4_0_8_8 = 33,
    Unspecified
  );

  TLogLevel = (
    Debug,
    Info,
    Warn,
    Error
  );

  TDiffusionModelType = (
    dtNone = 0,
    dtStableDiffusion = 1,
    dtFlux = 2
  );

  PSdCtx = Pointer;
  PUpscalerCtx = Pointer;

  PSDImage = ^TSDImage;
  TSDImage = record
    Width: UInt32;
    Height: UInt32;
    Channel: UInt32;
    Data: PByte;
  end;

  TSDParams = record
    NThreads: Integer;
    Mode: TSDMode;
    ModelPath: string;
    ClipLPath: string;
    T5xxlPath: string;
    DiffusionModelPath: string;
    VaePath: string;
    TaesdPath: string;
    EsrganPath: string;
    ControlnetPath: string;
    EmbeddingsPath: string;
    StackedIdEmbeddingsPath: string;
    InputIdImagesPath: string;
    WType: TQuantization;
    LoraModelDir: string;
    OutputPath: string;
    InputPath: string;
    ControlImagePath: string;
    Prompt: string;
    NegativePrompt: string;
    MinCfg: Single;
    CfgScale: Single;
    Guidance: Single;
    StyleRatio: Single;
    ClipSkip: Integer;
    Width: Integer;
    Height: Integer;
    BatchCount: Integer;
    VideoFrames: Integer;
    MotionBucketId: Integer;
    Fps: Integer;
    AugmentationLevel: Single;
    SampleMethod: TSampler;
    Schedule: TSchedule;
    SampleSteps: Integer;
    Strength: Single;
    ControlStrength: Single;
    RngType: TRngType;
    Seed: Int64;
    Verbose: Boolean;
    VaeTiling: Boolean;
    ControlNetCPU: Boolean;
    NormalizeInput: Boolean;
    ClipOnCPU: Boolean;
    VaeOnCPU: Boolean;
    CannyPreprocess: Boolean;
    Color: Boolean;
    UpscaleRepeats: Integer;

    class function Create: TSDParams; static;
  end;

  TSDLogCallback = procedure (Level: TLogLevel; const Text: PAnsiChar; Data: Pointer); cdecl;
  TSDProgressCallback = procedure (Step, Steps: Integer; Time: Single; Data: Pointer); cdecl;

const
  LIB_NAME = 'stable-diffusion.dll';

procedure Convert(const InputPath, VaePath, OutputPath: PAnsiChar;
  OutputType: TQuantization); cdecl; external LIB_NAME name 'convert';

procedure FreeSDCtx(SDCtx: PSdCtx); cdecl; external LIB_NAME name 'free_sd_ctx';

procedure FreeUpscaleCtx(UpscalerCtx: PUpscalerCtx); cdecl; external LIB_NAME name 'free_upscaler_ctx';

function GetNumPhysicalCores: Integer; cdecl; external LIB_NAME name 'get_num_physical_cores';

function Img2Img(SDCtx: PSdCtx; InitImage: TSDImage; const Prompt, NegativePrompt: PAnsiChar;
  ClipSkip: Integer; CfgScale, Guidance: Single; Width, Height: Integer;
  SampleMethod: TSampler; SampleSteps: Integer; Strength: Single; Seed: Int64;
  BatchCount: Integer; ControlCond: PSDImage; ControlStrength, StyleStrength: Single;
  NormalizeInput: Boolean; const InputIdImagesPath: PAnsiChar): PSDImage; cdecl; external LIB_NAME name 'img2img';

function Img2Vid(SDCtx: PSdCtx; InitImage: TSDImage; Width, Height, VideoFrames,
  MotionBucketId, Fps: Integer; AugmentationLevel, MinCfg, CfgScale: Single;
  SampleMethod: TSampler; SampleSteps: Integer; Strength: Single;
  Seed: Int64): PSDImage; cdecl; external LIB_NAME name 'img2vid';

function NewSDCtx(const ModelPath, ClipPath, T5xxlPath, DiffusionModelPath, VaePath, TaesdPath,
  ControlNetPathCStr, LoraModelDir, EmbedDirCStr, StackedIdEmbedDirCStr: PAnsiChar;
  VaeDecodeOnly, VaeTiling, FreeParamsImmediately: Boolean;
  NThreads: Integer; WType: TQuantization; RngType: TRngType; S: TSchedule;
  KeepClipOnCpu, KeepControlNetCpu, KeepVaeOnCpu: Boolean): PSdCtx; cdecl; external LIB_NAME name 'new_sd_ctx';

function NewUpscalerCtx(const ESRGANPath: PAnsiChar; NThreads: Integer;
  WType: TQuantization): PUpscalerCtx; cdecl; external LIB_NAME name 'new_upscaler_ctx';

function PreprocessCanny(Img: PByte; Width, Height: Integer;
  HighThreshold, LowThreshold, Weak, Strong: Single;
  Inverse: Boolean): PByte; cdecl; external LIB_NAME name 'preprocess_canny';

function SDGetSystemInfo: PAnsiChar; cdecl; external LIB_NAME name 'sd_get_system_info';

procedure SDSetLogCallback(SDLogCb: TSDLogCallback; Data: Pointer); cdecl; external LIB_NAME name 'sd_set_log_callback';

procedure SDSetProgressCallback(Cb: TSDProgressCallback; Data: Pointer); cdecl; external LIB_NAME name 'sd_set_progress_callback';

function SDTypeName(SDType: Pointer): PAnsiChar; cdecl; external LIB_NAME name 'sd_type_name';

function Txt2Img(SDCtx: PSdCtx; const Prompt, NegativePrompt: PAnsiChar;
  ClipSkip: Integer; CfgScale, Guidance: Single; Width, Height: Integer;
  SampleMethod: TSampler; SampleSteps: Integer; Seed: Int64; BatchCount: Integer;
  ControlCond: PSDImage; ControlStrength, StyleStrength: Single;
  NormalizeInput: Boolean; const InputIdImagesPath: PAnsiChar): PSDImage; cdecl; external LIB_NAME name 'txt2img';

function Upscale(UpscalerCtx: PUpscalerCtx; InputImage: TSDImage;
  UpscaleFactor: Integer): TSDImage; cdecl; external LIB_NAME name 'upscale';





implementation

{ TSDParams }

class function TSDParams.Create: TSDParams;
begin
  Result.NThreads := -1;
  Result.Mode := SMTXT2IMG;
  Result.WType := Unspecified;
  Result.OutputPath := 'output.png';
  Result.MinCfg := 1.0;
  Result.CfgScale := 7.0;
  Result.Guidance := 3.5;
  Result.StyleRatio := 20.0;
  Result.ClipSkip := -1;
  Result.Width := 512;
  Result.Height := 512;
  Result.BatchCount := 1;
  Result.VideoFrames := 6;
  Result.MotionBucketId := 127;
  Result.Fps := 6;
  Result.AugmentationLevel := 0.0;
  Result.SampleMethod := Euler_A;
  Result.Schedule := Default;
  Result.SampleSteps := 20;
  Result.Strength := 0.75;
  Result.ControlStrength := 0.9;
  Result.RngType := Cuda;
  Result.Seed := 42;
  Result.Verbose := False;
  Result.VaeTiling := False;
  Result.ControlNetCPU := False;
  Result.NormalizeInput := False;
  Result.ClipOnCPU := False;
  Result.VaeOnCPU := False;
  Result.CannyPreprocess := False;
  Result.Color := False;
  Result.UpscaleRepeats := 1;
end;

end.
